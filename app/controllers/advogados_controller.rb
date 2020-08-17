class AdvogadosController < ApplicationController
  before_action :set_advogado, only: [:show, :edit, :update, :destroy]

  # GET /advogados
  # GET /advogados.json
  def index
    @advogados = Advogado.all
  end

  # GET /advogados/1
  # GET /advogados/1.json
  def show
  end

  # GET /advogados/new
  def new
    @advogado = Advogado.new
  end

  # GET /advogados/1/edit
  def edit
  end

  # POST /advogados
  # POST /advogados.json
  def create
    @advogado = Advogado.new(advogado_params)

    respond_to do |format|
      if @advogado.save
        format.html { redirect_to @advogado, notice: 'Advogado was successfully created.' }
        format.json { render :show, status: :created, location: @advogado }
      else
        format.html { render :new }
        format.json { render json: @advogado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advogados/1
  # PATCH/PUT /advogados/1.json
  def update
    respond_to do |format|
      if @advogado.update(advogado_params)
        format.html { redirect_to @advogado, notice: 'Advogado foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @advogado }
      else
        format.html { render :edit }
        format.json { render json: @advogado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advogados/1
  # DELETE /advogados/1.json
  def destroy
    @advogado.destroy
    respond_to do |format|
      format.html { redirect_to advogados_url, notice: 'Advogado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advogado
      @advogado = Advogado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def advogado_params
      params.require(:advogado).permit(:nome, :endereço, :cidade, :bairro, :cep, :telefone, :cidade, :email, :advogado, :oab, :telefone, :observação, :cadastro_atendimento_id)
    end
end
