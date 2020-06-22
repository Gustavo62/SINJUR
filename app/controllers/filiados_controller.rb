class FiliadosController < ApplicationController
  layout 'restrito'
  before_action :set_filiado, only: [:show, :edit, :update, :destroy]

  # GET /filiados
  # GET /filiados.json
  def index
    if params[:serventia] or params[:cidade]
      if params[:cidade] != ""
        @filiados = Filiado.where(cidade: params[:cidade])
      else
        if params[:serventia] != ""
          @filiados = Filiado.where(codigo_tj: params[:serventia])
        else
          @filiados = Filiado.all    
        end
      end
    else
      @filiados = Filiado.all
    end
    @local = "Filiados >> Listar Filiados"
  end

  # GET /filiados/1
  # GET /filiados/1.json
  def show
    @local = "Filiados >> Visualizar Filiado"
  end

  # GET /filiados/new
  def new 
    @filiado = Filiado.new 
    @local = "Filiados >> Novo"
  end

  # GET /filiados/1/edit
  def edit
    @local = "Filiados >> Editar Filiado"
  end

  # POST /filiados
  # POST /filiados.json
  def create
    @filiado = Filiado.new(filiado_params)

    respond_to do |format|
      if @filiado.save
        format.html { redirect_to @filiado, notice: 'Filiado was successfully created.' }
        format.json { render :show, status: :created, location: @filiado }
      else
        format.html { render :new }
        format.json { render json: @filiado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filiados/1
  # PATCH/PUT /filiados/1.json
  def update
    respond_to do |format|
      if @filiado.update(filiado_params)
        format.html { redirect_to @filiado, notice: 'Filiado was successfully updated.' }
        format.json { render :show, status: :ok, location: @filiado }
      else
        format.html { render :edit }
        format.json { render json: @filiado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filiados/1
  # DELETE /filiados/1.json
  def destroy
    @filiado.destroy
    respond_to do |format|
      format.html { redirect_to filiados_url, notice: 'Filiado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filiado
      @filiado = Filiado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filiado_params
      params.require(:filiado).permit(:cnpj, :cei, :codigo_tj, :codigo_cnpj, :nome_contato, :cep, :logradouro, :numero_casa, :complemento, :bairro, :telefone_fixo_casa, :cidade, :email)
    end
end
