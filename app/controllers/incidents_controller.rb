class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]
  before_action :get_incidents, only: [:index]
  before_action :get_equipements, only: [:new, :edit]

  def index
  end
  def show
  end
  def new
    @incident = Incident.new
    @incident.equipements.build
  end
  def edit
    @incident.equipements.build
  end
  def create
    @incident = Incident.new(incident_params)
    if @incident.equipements.empty?
      flash[:alert] = "Pas d'équipement sélectionné"
      redirect_to new_incident_path
    elsif @incident.equipements.where(sla: @incident.equipements.first.sla).count == @incident.equipements.count
      flash[:alert] = "Les équipements sélectionnées n'ont pas la même SLA !"
      redirect_to new_incident_path
    elsif @incident.save
      UserMailer.with(incident: @incident).incident_email.deliver_now
      flash[:notice] = "L'incident a été enregistré et notifié par mail à la hotline NXO et à dip.reseau"
      redirect_to incidents_path
    end
  end
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to incidents_url, notice: "L'incident a été mis à jour" }
      else
        format.html { render :edit }
      end
    end
  end
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: "L'incident a été supprimé" }
    end
  end

  private
    def set_incident
      @incident = Incident.find(params[:id])
    end
    def get_incidents
      @incidents = Incident.all
    end
    def get_equipements
      @eqs = Array(Equipement.select('id, modele, marque, ip, serial, nom, sla').where.not(ip: ['', nil], marque: ['Unknown', 'Aerohive'], sla: ['', nil]).order(:marque))
    end
    def incident_params
      params.require(:incident).permit(:user_id, :debut, :fin, :idnxo, :idasap, :commentaire, equipement_ids: [])
    end
end
