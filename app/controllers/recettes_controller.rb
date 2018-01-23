class RecettesController < ApplicationController
  before_action :set_recette, only: [:show, :edit, :update, :destroy]
  before_action :get_enr, :get_localisation, :get_ligne, only: [:new, :edit, :create]


  def index
    @recettes = Recette.all
    @nb = Recette.all.count
  end

  def show
  end

  def dashboard
    @brocades = Equipement.where(marque:"Brocade")
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
        format.html { redirect_to @recette, notice: "La recette de l'équipement #{@recette.equipement.nom} a bien été modifiée." }
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
    def get_localisation
      @localisations = Localisation.all.order(:ville).order(:nom)
    end
    def get_ligne
      @lignes = Ligne.all.order(:numerocompte).order(:ndi)
    end
    def set_recette
      @recette = Recette.find(params[:id])
    end

    def recette_params
      params.require(:recette).permit(:user_id, :equipement_id, :ligne_id, :localisation_id, :snmp, :tacacs, :testdebit, :supervision, :etiquette)
    end

    def get_enr
      @enr = []
      Equipement.all.order(updated_at: :desc).each do |e|
        unless e.recette
          @enr.push(e)
        end
      end
    end

end
