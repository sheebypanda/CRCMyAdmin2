class RecettesController < ApplicationController
  before_action :set_recette, only: [:show, :edit, :update, :destroy]

  def index
    @recettes = Recette.all
  end

  def show
  end

  def new
    @recette = Recette.new
    @equipements = Equipement.all.order(updated_at: :desc)
    #TODO retirer les equipements qui ont deja une recette
  end

  def edit
  end

  def create
    @recette = Recette.new(recette_params)
    @recette.user = current_user
    respond_to do |format|
      if @recette.save
        format.html { redirect_to @recette, notice: 'Recette was successfully created.' }
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
        format.html { redirect_to @recette, notice: 'Recette was successfully updated.' }
        format.json { render :show, status: :ok, location: @recette }
      else
        format.html { render :edit }
        format.json { render json: @recette.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recette.destroy
    respond_to do |format|
      format.html { redirect_to recettes_url, notice: 'Recette was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recette
      @recette = Recette.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recette_params
      params.require(:recette).permit(:user_id, :equipement_id, :ligne_id, :localisation_id, :snmp, :tacacs, :testdebit, :supervision, :etiquette)
    end

end
