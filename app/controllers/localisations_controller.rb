class LocalisationsController < ApplicationController
  before_action :set_localisation, only: [:show, :edit, :update, :destroy]

  def index
    @villes = Localisation.select(:ville).distinct.order(:ville)
    if params[:search].present?
     @localisations = Localisation.localisation_search(params[:search]).page params[:page]
     @nb = Localisation.localisation_search(params[:search]).count
    else
      if params[:ville_id]
        @localisations = Localisation.where(ville: params[:ville_id]).page(params[:page]).per(100)
      else
        @localisations = Localisation.order(:adresse).page params[:page]
        @nb = Localisation.all.count
        respond_to do |format|
          format.html
          format.csv do
            @lo = Localisation.all
            headers['Content-Disposition'] = "attachment; filename=\"InventaireLocalisation.csv\""
            headers['Content-Type'] ||= 'text/csv'
          end
        end
      end
    end
  end

  def new
    @localisation = Localisation.new
  end

  def edit
  end

  def import
    begin
      Localisation.import(params[:file])
      redirect_to localisations_path, notice: 'Localisations importés ! :-)'
    rescue
      redirect_to localisations_path, notice: 'CSV invalide ! :-('
    end
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
        format.html { redirect_to localisations_path, notice: "La localisation #{@localisation.nom} a bien été mise à jour." }
        format.json { render :show, status: :ok, location: @localisation }
      else
        format.html { render :edit }
      end
    end
  end

  def delete_image
    image = ActiveStorage::Attachment.find(params[:format])
    image.purge
    redirect_to localisations_path
  end

  def destroy
    @localisation.destroy
    redirect_back fallback_location: localisations_path, notice: "La localisation #{@localisation.nom} a bien été supprimée."
  end

  private
    def set_localisation
      @localisation = Localisation.find(params[:id])
    end

    def localisation_params
      params.require(:localisation).permit(
        :nom,
        :adresse,
        :codepostal,
        :ville,
        :etage,
        :tel,
        :mail,
        :horaires,
        :description,
        :lat,
        :lng,
        :bp,
        :rattachement,
        images: [])
    end
end
