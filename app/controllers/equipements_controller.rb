class EquipementsController < ApplicationController
  before_action :set_equipement, only: [:show, :edit, :update, :destroy]

  # GET /equipements
  # GET /equipements.json
  def index
    @equipements = Equipement.all.order(updated_at: :desc).limit(200)
  end

  # GET /equipements/1
  # GET /equipements/1.json
  def show
  end

  # GET /equipements/new
  def new
    @equipement = Equipement.new
  end

  # GET /equipements/1/edit
  def edit
  end

  # POST /equipements
  # POST /equipements.json
  def create
    @equipement = Equipement.new(equipement_params)

    respond_to do |format|
      if @equipement.save
        format.html { redirect_to @equipement, notice: 'Equipement was successfully created.' }
        format.json { render :show, status: :created, location: @equipement }
      else
        format.html { render :new }
        format.json { render json: @equipement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipements/1
  # PATCH/PUT /equipements/1.json
  def update
    respond_to do |format|
      if @equipement.update(equipement_params)
        format.html { redirect_to @equipement, notice: 'Equipement was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipement }
      else
        format.html { render :edit }
        format.json { render json: @equipement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipements/1
  # DELETE /equipements/1.json
  def destroy
    @equipement.destroy
    respond_to do |format|
      format.html { redirect_to equipements_url, notice: 'Equipement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipement
      @equipement = Equipement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipement_params
      params.require(:equipement).permit(:nom, :marque, :modele, :snmpcontact, :dns, :iosv, :ip, :achat, :garantie, :asapid, :serial)
    end
end
