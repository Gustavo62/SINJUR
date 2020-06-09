class TabeliaosController < ApplicationController
  before_action :set_tabeliao, only: [:show, :edit, :update, :destroy]

  # GET /tabeliaos
  # GET /tabeliaos.json
  def index
    @tabeliaos = Tabeliao.all
  end

  # GET /tabeliaos/1
  # GET /tabeliaos/1.json
  def show
  end

  # GET /tabeliaos/new
  def new
    @tabeliao = Tabeliao.new
  end

  # GET /tabeliaos/1/edit
  def edit
  end

  # POST /tabeliaos
  # POST /tabeliaos.json
  def create
    @tabeliao = Tabeliao.new(tabeliao_params)

    respond_to do |format|
      if @tabeliao.save
        format.html { redirect_to @tabeliao, notice: 'Tabeliao was successfully created.' }
        format.json { render :show, status: :created, location: @tabeliao }
      else
        format.html { render :new }
        format.json { render json: @tabeliao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tabeliaos/1
  # PATCH/PUT /tabeliaos/1.json
  def update
    respond_to do |format|
      if @tabeliao.update(tabeliao_params)
        format.html { redirect_to @tabeliao, notice: 'Tabeliao was successfully updated.' }
        format.json { render :show, status: :ok, location: @tabeliao }
      else
        format.html { render :edit }
        format.json { render json: @tabeliao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tabeliaos/1
  # DELETE /tabeliaos/1.json
  def destroy
    @tabeliao.destroy
    respond_to do |format|
      format.html { redirect_to tabeliaos_url, notice: 'Tabeliao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tabeliao
      @tabeliao = Tabeliao.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tabeliao_params
      params.require(:tabeliao).permit(:nome, :cpf, :numero)
    end
end
