class LivraisonsController < ApplicationController
  before_action :set_livraison, only: [:edit, :update, :destroy]

  def index
    @livraisons = Livraison.all
  end

  def new
    @livraison = Livraison.new
  end

  def edit
  end

  def create
    @livraison = Livraison.new(livraison_params)

    respond_to do |format|
      if @livraison.save
        format.html { redirect_to livraisons_url, notice: 'Livraison ajoutée' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @livraison.update(livraison_params)
        format.html { redirect_to livraisons_url, notice: 'Livraison mise à jour' }
      else
        format.html { render :edit }
      end
    end
  end

  def delete_pv
    pv = ActiveStorage::Attachment.find(params[:format])
    pv.purge
    redirect_to livraisons_path
  end

  def destroy
    @livraison.destroy
    respond_to do |format|
      format.html { redirect_to livraisons_url, notice: 'Livraison supprimée' }
    end
  end

  private
    def set_livraison
      @livraison = Livraison.find(params[:id])
    end

    def livraison_params
      params.require(:livraison).permit(:user_id, :nom, :commande, :commentaire, :partielle, pvs: [])
    end
end
