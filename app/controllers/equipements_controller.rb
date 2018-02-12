class EquipementsController < ApplicationController
  before_action :set_equipement, only: [:show, :edit, :update, :destroy]

  def index
    @equipements = Equipement.where.not(ip: '').order(updated_at: :desc).page params[:page]
    @nb = Equipement.count
  end

  def show
  end

  def new
    @equipement = Equipement.new
  end

  def edit
  end

  def stock
    @stock = Equipement.where(nom: nil).or(Equipement.where(nom: ''))
  end

  def create
    @equipement = Equipement.new(equipement_params)

    respond_to do |format|
      if @equipement.save
        format.html { redirect_to '/stock', notice: "L'équipement #{@equipement.nom} a bien été créé" }
        format.json { render :show, status: :created, location: @equipement }
      else
        format.html { render :new }
        format.json { render json: @equipement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @equipement.update(equipement_params)
        format.html { redirect_to equipements_path, notice: "L'équipement #{@equipement.nom} a bien été modifié" }
        format.json { render :show, status: :ok, location: @equipement }
      else
        format.html { render :edit }
        format.json { render json: @equipement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @equipement.destroy
    respond_to do |format|
      format.html { redirect_to equipements_path, notice: "L'équipement #{@equipement.nom} a bien été supprimé" }
      format.json { head :no_content }
    end
  end

  private
    def set_equipement
      @equipement = Equipement.find(params[:id])
    end

    def equipement_params
      params.require(:equipement).permit(:nom, :marque, :modele, :snmpcontact, :dns, :iosv, :ip, :achat, :garantie, :asapid, :serial)
    end
end
