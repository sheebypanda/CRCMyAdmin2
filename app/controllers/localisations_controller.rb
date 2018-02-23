class LocalisationsController < ApplicationController
  before_action :set_localisation, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
     @localisations = Localisation.localisation_search(params[:search]).page params[:page]
     @nb = Localisation.localisation_search(params[:search]).count
    else
      @localisations = Localisation.all.order(updated_at: :desc).page params[:page]
      @nb = Localisation.all.count

      @lo = Localisation.all
      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = "attachment; filename=\"InventaireLocalisation.csv\""
          headers['Content-Type'] ||= 'text/csv'
        end
      end


    end
  end

  def show
  end

  def new
    @localisation = Localisation.new
  end

  def edit
  end

  def create
    @localisation = Localisation.new(localisation_params)

    respond_to do |format|
      if @localisation.save
        format.html { redirect_to localisations_path, notice: "La localisation #{@localisation.nom} a bien été créée." }
        format.json { render :show, status: :created, location: @localisation }
      else
        format.html { render :new }
        format.json { render json: @localisation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @localisation.update(localisation_params)
        format.html { redirect_to localisations_path, notice: "La localisation #{@localisation.nom} a bien été créée." }
        format.json { render :show, status: :ok, location: @localisation }
      else
        format.html { render :edit }
        format.json { render json: @localisation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @localisation.destroy
    respond_to do |format|
      format.html { redirect_to localisations_url, notice: "La localisation #{@localisation.nom} a bien été supprimée." }
      format.json { head :no_content }
    end
  end

  private
    def set_localisation
      @localisation = Localisation.find(params[:id])
    end

    def localisation_params
      params.require(:localisation).permit(:nom, :adresse, :codepostal, :ville, :etage, :tel, :mail, :description, :lat, :lng)
    end
end
