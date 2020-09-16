class AssuntoAtendimentosController < ApplicationController
  layout 'restrito'
  before_action :set_assunto_atendimento, only: [:show, :edit, :update, :destroy]

  # GET /assunto_atendimentos
  # GET /assunto_atendimentos.json
  def index
    @assunto_atendimentos = AssuntoAtendimento.page(params[:page]).per(15)
    @local = 'Atendimento > Ferramentas > Assuntos > Listar.'
  end

  # GET /assunto_atendimentos/1
  # GET /assunto_atendimentos/1.json
  def show
  end

  # GET /assunto_atendimentos/new
  def new
    @assunto_atendimento = AssuntoAtendimento.new
    @local = 'Atendimento > Ferramentas > Assuntos > Novo.'
  end

  # GET /assunto_atendimentos/1/edit
  def edit
    @local = 'Atendimento > Ferramentas > Assuntos > Editar.'
  end

  # POST /assunto_atendimentos
  # POST /assunto_atendimentos.json
  def create
    @assunto_atendimento = AssuntoAtendimento.new(assunto_atendimento_params)

    respond_to do |format|
      if @assunto_atendimento.save
        format.html { redirect_to assunto_atendimentos_url, notice: 'Assunto criado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @assunto_atendimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assunto_atendimentos/1
  # PATCH/PUT /assunto_atendimentos/1.json
  def update
    respond_to do |format|
      if @assunto_atendimento.update(assunto_atendimento_params)
        format.html { redirect_to assunto_atendimentos_url, notice: 'Assunto atualizado com sucesso.' }
        format.json { head :no_content}
      else
        format.html { render :edit }
        format.json { render json: @assunto_atendimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assunto_atendimentos/1
  # DELETE /assunto_atendimentos/1.json
  def destroy
    @assunto_atendimento.destroy
    respond_to do |format|
      format.html { redirect_to assunto_atendimentos_url, notice: 'Assunto excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assunto_atendimento
      @assunto_atendimento = AssuntoAtendimento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assunto_atendimento_params
      params.require(:assunto_atendimento).permit(:assunto, :descricao , :usuario)
    end
end
