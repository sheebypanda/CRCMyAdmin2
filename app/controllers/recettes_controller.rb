class RecettesController < ApplicationController
  before_action :set_recette, only: [:show, :edit, :update, :destroy]
  before_action :get_localisations, :get_lignes, only: [:new, :edit, :create]
  before_action :get_enr, :get_ville, only:[:new]
  before_action :get_equipements, only:[:edit]
  before_action :check_search


  def index
    if params[:search].present?
      @recettes = PgSearch.multisearch(params[:search]).page params[:page]
    else
      @recettes = Recette.all.order(created_at: :desc).page params[:page]
      @nb = Recette.all.count
    end
  end

  def show
  end

  def dashboard
  end

  def new
    @recette = Recette.new
  end

  def edit
  end

  def create
    @recette = Recette.new(recette_params)
    @recette.user = current_user
    respond_to do |format|
      if @recette.save
        format.html { redirect_to recettes_path, notice: "La recette de l'équipement #{@recette.equipement.nom} a bien été créée." }
        format.json { render :show, status: :created, location: @recette }
      else
        format.html { render :new }
        format.json { render json: @recette.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recette.update(recette_params)
        format.html { redirect_to recettes_path, notice: "La recette de l'équipement #{@recette.equipement.nom} a bien été modifiée." }
        format.json { render :index, status: :ok, location: @recette }
      else
        format.html { render :edit }
        format.json { render json: @recette.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recette.destroy
    respond_to do |format|
      format.html { redirect_to recettes_url, notice:  "La recette de l'équipement #{@recette.equipement.nom} a bien été supprimée." }
      format.json { head :no_content }
    end
  end

  private
    def get_equipements
      @equipements = Equipement.all.order(updated_at: :desc)
    end
    def get_localisations
      @localisations = Localisation.all.order(:ville).order(:nom)
    end
    def get_ville
      @villes = Localisation.distinct.pluck(:ville)
    end
    def get_lignes
      @lignes = Ligne.all.order(:numerocompte).order(:ndi)
    end
    def set_recette
      @recette = Recette.find(params[:id])
    end

    def recette_params
      params.require(:recette).permit(
        :user_id,
        :equipement_id,
        :ligne_id,
        :localisation_id,
        :snmp,
        :tacacs,
        :testdebit,
        :supervision,
        :etiquette)
    end

    def get_enr
      @equipements = []
      Equipement.where.not(nom: ['', nil]).order(updated_at: :desc).each do |e|
        unless e.recette
          @equipements.push(e)
        end
      end
    end

    def check_search
      if params[:search].present?
        @recettes = PgSearch.multisearch(params[:search]).page params[:page]
        render :index, search: params[:search]
      end
    end

end
