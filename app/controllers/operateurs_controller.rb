class OperateursController < ApplicationController
  before_action :set_operateur, only: [:show, :edit, :update, :destroy]

  # GET /operateurs
  # GET /operateurs.json
  def index
    @operateurs = Operateur.all
  end

  # GET /operateurs/1
  # GET /operateurs/1.json
  def show
  end

  # GET /operateurs/new
  def new
    @operateur = Operateur.new
  end

  # GET /operateurs/1/edit
  def edit
  end

  # POST /operateurs
  # POST /operateurs.json
  def create
    @operateur = Operateur.new(operateur_params)

    respond_to do |format|
      if @operateur.save
        format.html { redirect_to @operateur, notice: 'Operateur was successfully created.' }
        format.json { render :show, status: :created, location: @operateur }
      else
        format.html { render :new }
        format.json { render json: @operateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operateurs/1
  # PATCH/PUT /operateurs/1.json
  def update
    respond_to do |format|
      if @operateur.update(operateur_params)
        format.html { redirect_to @operateur, notice: 'Operateur was successfully updated.' }
        format.json { render :show, status: :ok, location: @operateur }
      else
        format.html { render :edit }
        format.json { render json: @operateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operateurs/1
  # DELETE /operateurs/1.json
  def destroy
    @operateur.destroy
    respond_to do |format|
      format.html { redirect_to operateurs_url, notice: 'Operateur was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operateur
      @operateur = Operateur.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operateur_params
      params.require(:operateur).permit(:nom, :hotline)
    end
end
