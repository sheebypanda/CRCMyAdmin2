class ProjetsController < ApplicationController
  before_action :set_projet, only: [:show, :edit, :update, :destroy]

  def index
    @projets = Projet.all
  end

  def show
  end

  def new
    @projet = Projet.new
    @projet.equipements.build
    @eqs = Array(Equipement.select('id, modele, marque').where(ip: ['', nil], projet_id: ['', nil]).order(:marque))
  end

  def edit
    @projet.equipements.build
    @eqs = Array(Equipement.select('id, modele, marque').where(ip: ['', nil], projet_id: ['', nil]).order(:marque))
  end

  def create
    @projet = Projet.new(projet_params)
    respond_to do |format|
      if @projet.save
        format.html { redirect_to projets_path, notice: 'Le projet a été créé' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @projet.update(projet_params)
        format.html { redirect_to @projet, notice: 'Projet mis à jour' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @projet.destroy
    respond_to do |format|
      format.html { redirect_to projets_url, notice: 'Le projet a été supprimé' }
      format.js
    end
    Equipement.where(projet_id: @projet.id).each do |e|
      e.projet_id = nil
      e.save!
    end
  end

  private
    def set_projet
      @projet = Projet.find(params[:id])
    end

    def projet_params
      params.require(:projet).permit(:user_id, :titre, :date, equipement_ids: [])
    end

end
