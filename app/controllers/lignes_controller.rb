class LignesController < ApplicationController
  before_action :set_ligne, only: [:show, :edit, :update, :destroy]

  def index
    @villes = Localisation.select(:ville).distinct
    if params[:search].present?
     @lignes = Ligne.ligne_search(params[:search]).page params[:page]
     @nb = Ligne.ligne_search(params[:search]).count
    else
      if params[:ville_id]
        @lignes = []
        Localisation.where(ville: params[:ville_id]).each do |v|
          v.recettes.each do |r|
            if r.ligne.numerocompte
              unless r.ligne.numerocompte.include?  'Fibre priv'
                @lignes << r.ligne
              end
            end
          end
        end
        @lignes.uniq!
      else
        @lignes = Ligne.all.order(updated_at: :desc).page params[:page]
        @nb = Ligne.all.count

        @li = Ligne.all
        respond_to do |format|
          format.html
          format.csv do
            headers['Content-Disposition'] = "attachment; filename=\"InventaireLignes.csv\""
            headers['Content-Type'] ||= 'text/csv'
          end
        end
      end
    end
  end

  def show
  end

  def new
    @ligne = Ligne.new
  end

  def edit
  end

  def import
    # begin
      Ligne.import(params[:file])
      redirect_to lignes_path, notice: 'Lignes importés ! :-)'
    # rescue
      # redirect_to lignes_path, notice: 'CSV invalide ! :-('
    # end
  end

  def create
    @ligne = Ligne.new(ligne_params)

    respond_to do |format|
      if @ligne.save
        format.html { redirect_to lignes_path, notice: "La ligne #{@ligne.numerocompte} a bien été créée." }
        format.json { render :index, status: :created, location: @ligne }
      else
        format.html { render :new }
        format.json { render json: @ligne.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ligne.update(ligne_params)
        format.html { redirect_to lignes_path, notice: "La ligne #{@ligne.numerocompte} a bien été modifiée." }
        format.json { render :show, status: :ok, location: @ligne }
      else
        format.html { render :edit }
        format.json { render json: @ligne.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ligne.destroy
    redirect_back fallback_location: localisations_path, notice: "La ligne #{@ligne.numerocompte} a bien été supprimée."
  end

  private
    def set_ligne
      @ligne = Ligne.find(params[:id])
    end

    def ligne_params
      params.require(:ligne).permit(:numerocompte, :techno, :cout, :ndi, :debit, :ippublique, :mail, :tel, :identifiantoperateur, :mdpoperateur, :compte, :motdepasse, :operateur_id)
    end
end
