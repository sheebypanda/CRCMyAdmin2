class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  def index
    @incidents = Incident.all
  end
  def show
  end
  def new
    @incident = Incident.new
    @incident.equipements.build
    @eqs = Array(Equipement.select('id, modele, marque, ip, serial, nom').where.not(ip: ['', nil], marque: ['Unknown', 'Aerohive']).order(:marque))
  end
  def edit
    @eqs = Array(Equipement.select('id, modele, marque, ip, serial, nom').where.not(ip: ['', nil], marque: ['Unknown', 'Aerohive']).order(:marque))
    @incident.equipements.build
  end
  def create
    @incident = Incident.new(incident_params)
    respond_to do |format|
      if @incident.save
        format.html { redirect_to incidents_url, notice: "L'incident a été enregistré" }
      else
        format.html { render :new }
      end
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

    def incident_params
      params.require(:incident).permit(:user_id, :debut, :fin, :idnxo, :idasap, :commentaire, equipement_ids: [])
    end
end
