class LignesController < ApplicationController
  before_action :set_ligne, only: [:show, :edit, :update, :destroy]
  before_action :get_villes, :get_operateurs, only: :index

  def index
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
    elsif params[:operateur_id]
      @lignes = Ligne.where(operateur_id: params[:operateur_id])
      @operateur_id = params[:operateur_id]
    else
      @lignes = Ligne.all.order(updated_at: :desc).page params[:page]
      # @lignes = Ligne.all.order(updated_at: :desc)
      respond_to do |format|
        format.html
        format.csv do
          @li = Ligne.all
          headers['Content-Disposition'] = "attachment; filename=\"InventaireLignes.csv\""
          headers['Content-Type'] ||= 'text/csv'
        end
      end
    end
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
    redirect_to lignes_path, notice: "La ligne #{@ligne.numerocompte} a bien été supprimée."
  end

  private
    def set_ligne
      @ligne = Ligne.find(params[:id])
    end

    def ligne_params
      params.require(:ligne).permit(:numerocompte, :techno, :cout, :ndi, :debit, :ippublique, :mail, :tel, :identifiantoperateur, :mdpoperateur, :compte, :motdepasse, :operateur_id)
    end

    def get_villes
      @villes = Localisation.select(:ville).distinct.order(:ville)
    end

    def get_operateurs
      @operateurs = Operateur.select(:id, :nom).sort
    end
end
