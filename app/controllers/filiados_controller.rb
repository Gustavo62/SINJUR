class FiliadosController < ApplicationController
  layout 'restrito'
  before_action :set_filiado, only: [:show, :edit, :update, :destroy]

  # GET /filiados
  # GET /filiados.json
  def index
    if params[:serventia] or params[:cidade]
      if params[:cidade] != ""
        @filiados = Filiado.where(cidade: params[:cidade].to_s.upcase).page(params[:page]).per(17)
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
    @filiado.usuario = current_admin.email
    @filiado.update_objt = current_admin.email
    respond_to do |format|
      if @filiado.save
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>@filiado.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@filiado.created_at.strftime('%d'), "hracao(2i)"=>@filiado.created_at.strftime('%m'), "hracao(1i)"=>@filiado.created_at.strftime('%Y'), "hracao(4i)"=>((@filiado.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@filiado.created_at.strftime('%M'),"usuario"=>@filiado.usuario, "acao_desc"=>"Adicionou um filiado, nome: #{@filiado.nome}","acao"=>"Adicionou", "objeto"=>"Filiado", "quem"=>@filiado.usuario) 
        @historico.save
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
    @filiado.update_objt = current_admin.email
    respond_to do |format|
      if @filiado.update(filiado_params)
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@filiado.update_objt, "acaoupdt"=>"Atualizou as informações do filiado, nome: #{@filiado.nome}", "objeto_id"=>@filiado.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@filiado.created_at.strftime('%d'), "hracao(2i)"=>@filiado.created_at.strftime('%m'), "hracao(1i)"=>@filiado.created_at.strftime('%Y'), "hracao(4i)"=>((@filiado.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@filiado.created_at.strftime('%M'),"usuario"=>@filiado.usuario, "acao_desc"=>"Adicionou um filiado, nome: #{@filiado.nome}","acao"=>"Atualizou", "objeto"=>"Filiado", "quem"=>@filiado.update_objt) 
        @historico.save
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
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@filiado.update_objt, "acaoupdt"=>"Excluiu o filiado, nome: #{@filiado.nome}", "objeto_id"=>@filiado.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@filiado.created_at.strftime('%d'), "hracao(2i)"=>@filiado.created_at.strftime('%m'), "hracao(1i)"=>@filiado.created_at.strftime('%Y'), "hracao(4i)"=>((@filiado.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@filiado.created_at.strftime('%M'),"usuario"=>@filiado.usuario, "acao_desc"=>"Adicionou um filiado, nome: #{@filiado.nome}","acao"=>"Excluiu", "objeto"=>"Filiado", "quem"=>@filiado.update_objt) 
    @historico.save
    @filiado.destroy
    respond_to do |format|
      format.html { redirect_to filiados_url, notice: 'Filiado foi deletado com sucesso.' }
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
      params.require(:filiado).permit(:cnpj, :cei, :serventia, :codigo_cnpj, :nome, :end_completo,:cep, :logradouro, :numero_casa, :complemento, :bairro, :telefone_fixo_casa, :cidade, :email, :titular , :usuario,:update_objt,:quem_username)
    end
end
