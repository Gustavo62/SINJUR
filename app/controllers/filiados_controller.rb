class FiliadosController < ApplicationController
  layout 'restrito'
  before_action :set_filiado, only: [:show, :edit, :update, :destroy]

  # GET /filiados
  # GET /filiados.json
  def index
    if params[:serventia] or params[:cidade]
      if params[:cidade] != ""
        @filiados = Filiado.where(cidade: params[:cidade]).page(params[:page]).per(17)
      else
        if params[:serventia] != ""
          @filiados = Filiado.where(serventia: params[:serventia]).page(params[:page]).per(17)
        else
          @filiados = Filiado.page(params[:page]).per(17)    
        end
      end
    else
      @filiados = Filiado.page(params[:page]).per(17)
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
        format.html { redirect_to @filiado, notice: 'Filiado foi foi criado com sucesso.' }
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
        format.html { redirect_to @filiado, notice: 'Filiado foi atualizado com sucesso.' }
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
    if current_user.email == @restrito_tela_agenda_atividade.usuario || user.admin?
      @filiado.destroy
      respond_to do |format|
        format.html { redirect_to filiados_url, notice: 'Filiado foi deletado com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filiado
      @filiado = Filiado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filiado_params
      params.require(:filiado).permit(:cnpj, :cei, :serventia, :codigo_cnpj, :nome, :end_completo,:cep, :logradouro, :numero_casa, :complemento, :bairro, :telefone_fixo_casa, :cidade, :email, :titular , :usuario,:update_objt)
    end
end
