class EquipementsController < ApplicationController
  before_action :set_equipement, only: [:show, :edit, :update, :destroy]
  require 'net/http'
  require 'uri'
  require 'json'
  require 'openssl'

  def index
    if params[:search].present?
     @equipements = Equipement.equipement_search(params[:search]).page params[:page]
    else
      @equipements = Equipement.where.not(ip: '').order(updated_at: :desc).page params[:page]
      @all = Equipement.where.not(ip: '').order(updated_at: :desc)
      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = "attachment; filename=\"InventaireEquipements.csv\""
          headers['Content-Type'] ||= 'text/csv'
        end
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
      end
    end
  end

  def show
  end

  def import
    begin
      Equipement.import(params[:file])
      redirect_to equipements_path, notice: 'Equipements importés ! :-)'
    rescue
      redirect_to equipements_path, notice: 'CSV invalide ! :-('
    end
  end

  def new
    @equipement = Equipement.new
  end

  def serials_update
    @serial_success = []
    @serial_errors = []
    equipements = Equipement.where.not(ip: [nil, ''])
    equipements.each do |e|
      devices_update(e)
      stack_update(e)
    end
  end

  def hosts_update
    @add_response = []
    @add_response2 = []
    eqs = Equipement.where.not(ip: [nil, ''])
    eqs.each do |e|
      libreNmsAdd(e.ip)
      @add_response << e
      @add_response2 << @response
    end
  end

  def edit
  end

  def stock
    @stock_brocade = Equipement.where("marque = ?", 'Brocade' ).where(nom: nil).or(Equipement.where(nom: ''))
    @stock_cisco = Equipement.where("marque = ?", 'Cisco' ).where(nom: nil).or(Equipement.where(nom: ''))
    @stock_aerohive = Equipement.where("marque = ?", 'Aerohive' ).where(nom: nil).or(Equipement.where(nom: ''))
    @stock_all = Equipement.where(nom: nil).or(Equipement.where(nom: ''))
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"EtatStock.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def create
    @equipement = Equipement.new(equipement_params)
    respond_to do |format|
      if @equipement.save
        format.html { redirect_to new_equipement_path, notice: "L'équipement #{@equipement.marque} #{@equipement.modele} #{@equipement.serial} a bien été créé" }
      else
        format.html { render :new }
      end
    end
  end

  def update
    unless equipement_params[:supervision]
      libreNmsAdd(equipement_params[:ip])
    end
    respond_to do |format|
      if @equipement.update(equipement_params)
        format.html { redirect_to equipements_path, notice: "L'équipement #{@equipement.nom} a bien été passé en prod. Supervision : #{@response}" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @equipement.destroy
    respond_to do |format|
      format.html { redirect_to equipements_path, notice: "L'équipement #{@equipement.nom} a bien été supprimé" }
    end
  end

  private
    def set_equipement
      @equipement = Equipement.find(params[:id])
    end

    def equipement_params
      params.require(:equipement).permit(
        :nom,
        :marque,
        :modele,
        :snmpcontact,
        :dns,
        :iosv,
        :ip,
        :achat,
        :garantie,
        :asapid,
        :serial,
        :supervision,
        :sla,
        :maintenance,
        :coutmaintenance,
        :datemaintenance)
    end

    def libreNmsAdd(ip)
      uri = URI.parse(Rails.application.secrets.supervision_api_url.to_s)
      request = Net::HTTP::Post.new(uri)
      request["X-Auth-Token"] = Rails.application.secrets.token
      request.body = JSON.dump({
        "hostname" => ip.to_s,
        "version" => "v3",
        "authlevel" => "authNoPriv",
        "authname" => Rails.application.secrets.snmp_auth_name.to_s,
        "authpass" => Rails.application.secrets.snmp_auth_pass.to_s,
        "authalgo" => "SHA",
        "force_add" => "true"
      })
      req_options = {
        use_ssl: uri.scheme == "https",
        verify_mode: OpenSSL::SSL::VERIFY_NONE,
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      @response = response.body
    end

    def devices_update(e)
      if e.ip
        url = URI.encode(Rails.application.secrets.supervision_api_url.to_s+"/"+e.ip)
        uri = URI.parse(url)
        req_options = {
          use_ssl: uri.scheme == "https",
          verify_mode: OpenSSL::SSL::VERIFY_NONE,
        }
        request = Net::HTTP::Get.new(uri)
        request["X-Auth-Token"] = Rails.application.secrets.token
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
        if response.code == "200"
          hash = JSON.parse(response.body)
          if !hash["devices"][0]["serial"].to_s.empty?
            e.serial = hash["devices"][0]["serial"]
            # if hash["devices"][0]["hardware"].present?
            #   e.modele = hash["devices"][0]["hardware"]
            # end
            if e.save!
              @serial_success << e
            else
              e.errors[:base] << "Erreur lors de l'enregistrement"
              @serial_errors << e
            end
          else
            inventory_update(e)
          end
        else
          e.errors[:base] << "LibreNMS ne connait pas cet hôte, ou n'arrive pas à le joindre"
          @serial_errors << e
        end
      end
    end

    def inventory_update(e)
      if e.ip
        url = URI.encode(Rails.application.secrets.supervision_api_url.to_s[0..-8]+"inventory/"+e.ip)
        uri = URI.parse(url)
        req_options = {
          use_ssl: uri.scheme == "https",
          verify_mode: OpenSSL::SSL::VERIFY_NONE,
        }
        request = Net::HTTP::Get.new(uri)
        request["X-Auth-Token"] = Rails.application.secrets.token
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
        if response.code == "200"
          hash = JSON.parse(response.body)
          if hash["inventory"]
            if !hash["inventory"][0].to_s.empty?
              e.serial = hash["inventory"][0]["entPhysicalSerialNum"]
              if e.save!
                @serial_success << e
              else
                e.errors[:base] << "Erreur lors de l'enregistrement"
                @serial_errors << e
              end
            else
              e.errors[:base] << "LibreNMS n'arrive pas à trouver de Serial pour cet equipement"
              @serial_errors << e
            end
          end
        else
          e.errors[:base] << "LibreNMS ne connait pas cet hôte, ou n'arrive pas à le joindre"
          @serial_errors << e
        end
      end
    end

    def stack_update(e)
      if e.ip
        url = URI.encode(Rails.application.secrets.supervision_api_url.to_s[0..-8]+"inventory/"+e.ip+"?entPhysicalContainedIn=1")
        uri = URI.parse(url)
        req_options = {
          use_ssl: uri.scheme == "https",
          verify_mode: OpenSSL::SSL::VERIFY_NONE,
        }
        request = Net::HTTP::Get.new(uri)
        request["X-Auth-Token"] = Rails.application.secrets.token
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
        if response.code == "200"
          hash = JSON.parse(response.body)
          for indexStack in 0..4
            if hash["inventory"]
              if !hash["inventory"][indexStack].to_s.empty?
                if !hash["inventory"][indexStack]["entPhysicalSerialNum"].empty?
                  if e.serial != hash["inventory"][indexStack]["entPhysicalSerialNum"]
                    e.serial = e.serial + " | " + hash["inventory"][indexStack]["entPhysicalSerialNum"]
                  end
                end
              end
            end
          end
          if e.save!
            @serial_success << e
          else
            e.errors[:base] << "Erreur lors de l'enregistrement"
            @serial_errors << e
          end
        end
      end
    end

end
