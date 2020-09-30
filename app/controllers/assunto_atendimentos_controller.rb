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
    @assunto_atendimento.usuario = current_admin.email
    @assunto_atendimento.update_objt = current_admin.email
    respond_to do |format|
      if @assunto_atendimento.save
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>@assunto_atendimento.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@assunto_atendimento.created_at.strftime('%d'), "hracao(2i)"=>@assunto_atendimento.created_at.strftime('%m'), "hracao(1i)"=>@assunto_atendimento.created_at.strftime('%Y'), "hracao(4i)"=>((@assunto_atendimento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@assunto_atendimento.created_at.strftime('%M'),"usuario"=>@assunto_atendimento.usuario, "acao_desc"=>"Adicionou um assunto de atendimento, assunto: #{@assunto_atendimento.assunto}","acao"=>"Adicionou", "objeto"=>"Assunto", "quem"=>@assunto_atendimento.usuario) 
        @historico.save
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
    @assunto_atendimento.update_objt = current_admin.email
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@assunto_atendimento.update_objt,"acaoupdt"=>"Atualizou as informações do assunto de atendimento, assunto: #{@assunto_atendimento.assunto}" ,"objeto_id"=>@assunto_atendimento.id, "hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@assunto_atendimento.created_at.strftime('%d'), "hracao(2i)"=>@assunto_atendimento.created_at.strftime('%m'), "hracao(1i)"=>@assunto_atendimento.created_at.strftime('%Y'), "hracao(4i)"=>((@assunto_atendimento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@assunto_atendimento.created_at.strftime('%M'),"usuario"=>@assunto_atendimento.usuario, "acao_desc"=>"Adicionou um assunto de atendimento, assunto: #{@assunto_atendimento.assunto}","acao"=>"Atualizou", "objeto"=>"Assunto", "quem"=>@assunto_atendimento.update_objt) 
    @historico.save
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
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@assunto_atendimento.update_objt,"acaoupdt"=>"Excluiu as informações do assunto de atendimento, assunto: #{@assunto_atendimento.assunto}" ,"objeto_id"=>@assunto_atendimento.id, "hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@assunto_atendimento.created_at.strftime('%d'), "hracao(2i)"=>@assunto_atendimento.created_at.strftime('%m'), "hracao(1i)"=>@assunto_atendimento.created_at.strftime('%Y'), "hracao(4i)"=>((@assunto_atendimento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@assunto_atendimento.created_at.strftime('%M'),"usuario"=>@assunto_atendimento.usuario, "acao_desc"=>"Adicionou um assunto de atendimento, assunto: #{@assunto_atendimento.assunto}","acao"=>"Excluiu", "objeto"=>"Assunto", "quem"=>@assunto_atendimento.update_objt) 
    @historico.save
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
      params.require(:assunto_atendimento).permit(:assunto, :descricao , :usuario,:update_objt,:quem_username)
    end
end
