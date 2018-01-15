class LignesController < ApplicationController
  before_action :set_ligne, only: [:show, :edit, :update, :destroy]

  # GET /lignes
  # GET /lignes.json
  def index
    @lignes = Ligne.all.order(updated_at: :desc)
  end

  # GET /lignes/1
  # GET /lignes/1.json
  def show
  end

  # GET /lignes/new
  def new
    @ligne = Ligne.new
  end

  # GET /lignes/1/edit
  def edit
  end

  # POST /lignes
  # POST /lignes.json
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

  # PATCH/PUT /lignes/1
  # PATCH/PUT /lignes/1.json
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

  # DELETE /lignes/1
  # DELETE /lignes/1.json
  def destroy
    @ligne.destroy
    respond_to do |format|
      format.html { redirect_to lignes_url, notice: "La ligne #{@ligne.numerocompte} a bien été supprimée." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ligne
      @ligne = Ligne.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ligne_params
      params.require(:ligne).permit(:numerocompte, :techno, :cout, :ndi, :debit, :ippublique, :mail, :tel, :identifiantoperateur, :mdpoperateur, :compte, :motdepasse, :operateur_id)
    end
end
