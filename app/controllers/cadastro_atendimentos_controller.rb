class CadastroAtendimentosController < ApplicationController
  layout 'restrito'
  before_action :set_cadastro_atendimento, only: [:show, :edit, :update, :destroy] 
  # GET /cadastro_atendimentos
  # GET /cadastro_atendimentos.json
  
  def index  
    '''
    if params[:n_atendimento] != nil
      @cadastro_atendimentos_aux = CadastroAtendimento.where(id: params[:n_atendimento]) 
    end
    if params[:codigoo_tj] != nil
      @cadastro_atendimentos_aux = CadastroAtendimento.where(codigo_tj_filiado: procura_cart )
    end 
    if params[:codigoo_tj] == nil && params[:n_atendimento] == nil
      @cadastro_atendimentos = CadastroAtendimento.all 
    end
    '''
    if params[:n_atendimento] or params[:codigoo_tj] or params[:intervalo_atend] or params[:cpf] or params[:intervalo_atend_cpf]
      if params[:n_atendimento] != ""
        @cadastro_atendimentos_aux = CadastroAtendimento.where(id: params[:n_atendimento]).page(params[:page]).per(22)
      else 
        if params[:codigoo_tj] != "" && params[:intervalo_atend] != ""
          @cadastro_atendimentos_aux = CadastroAtendimento.where(codigo_tj_filiado: procura_cart_tj ,data_atendimento: params[:intervalo_atend]).page(params[:page]).per(22)
        else
          if params[:intervalo_atend] != ""
            @cadastro_atendimentos_aux = CadastroAtendimento.where(data_atendimento: params[:intervalo_atend]).page(params[:page]).per(22)
          else
            if params[:codigoo_tj] != ""
              @cadastro_atendimentos_aux = CadastroAtendimento.where(codigo_tj_filiado: procura_cart_tj).page(params[:page]).per(22)
            else
              if params[:cpf] != "" && params[:intervalo_atend] != ""
                @cadastro_atendimentos_aux = CadastroAtendimento.where(data_atendimento: params[:intervalo_atend], cpf: params[:cpf]).page(params[:page]).per(22)
              else
                if params[:cpf] != ""
                  @cadastro_atendimentos_aux = CadastroAtendimento.where(cpf: params[:cpf]).page(params[:page]).per(22)
                else
                  @cadastro_atendimentos_aux = CadastroAtendimento.page(params[:page]).per(22)
                end
              end
            end
          end
        end
      end
    else
      @cadastro_atendimentos_aux = CadastroAtendimento.page(params[:page]).per(22)
    end
    @cadastro_atendimentos = CadastroAtendimento.all
    options_for_select  
    @local = 'Cadastro atendimento >> Listar Atendimento'
  end
  def data
    return Time.now.strftime("%d/%m/%y")
  end 
  def procura_cart_tj 
    Filiado.all.each do |filiados|
      if String(filiados.serventia) == params[:codigoo_tj]
        return filiados.id
      end
    end
  end 
  def options_for_select
    @filiados_for_select = Filiado.all
    @assunto_for_select = AssuntoAtendimento.all 
  end

  def testa_doc
    Documento.all.each do |doc|
      if doc.cadastro_atendimento_id == @cadastro_atendimento.id
        @testedoc  = true 
      end
    end
  end
  def testa_proc
    Processo.all.each do |proc|
      if proc.cadastro_atendimento_id == @cadastro_atendimento.id
        @testeproc  = true
      end
    end  
  end
  def testa_advg
    Advogado.all.each do |advg|
      if advg.cadastro_atendimento_id == @cadastro_atendimento.id
        @testeadv  = true
      end
    end 
  end
  def testa_pess
    Pessoa.all.each do |pess|
      if pess.cadastro_atendimento_id == @cadastro_atendimento.id
        @testepessoa  = true
      end
    end 
  end 
    # GET /cadastro_atendimentos/1
  # GET /cadastro_atendimentos/1.json
  def show
    @local = 'Cadastro atendimento >> Visualizar'
    @acao = 'Visualizar' 
    options_for_select
    testa_doc
    testa_advg
    testa_pess
    testa_proc 
    @count = 1
    if @testeadv    
      @posicao = 0
      @qtd_adv = @cadastro_atendimento.advogados.size
      if @cadastro_atendimento.advogados.size == 1
        @adv_plural = 'do advogado.'
        @cadastro_atendimento.advogados.each do |adovagos|
          @nome_adv = adovagos.nome
        end 
      else 
        @adv_plural = 'dos advogados.'
        @nome_adv = [] 
        @cadastro_atendimento.advogados.each do |adovagos|
          @nome_adv[@posicao] = adovagos.nome
          @posicao += 1
        end 
      end 
    else 
      @nome_adv = 'Sem advogado cadastrado neste atendimento' 
    end
    if @testepessoa    
      @posicao_array = 0
      @qtd_pess = @cadastro_atendimento.pessoas.size
      if @cadastro_atendimento.pessoas.size == 1
        @pess_plural = 'da pessoa envolvida.'
        @cadastro_atendimento.pessoas.each do |pess|
          @nome_pess = pess.nome
        end 
      else 
        @pess_plural = 'das pessoas envolvidas.'
        @nome_pess = [] 
        @cadastro_atendimento.pessoas.each do |pess|
          @nome_pess[@posicao_array] = pess.nome
          @posicao_array += 1
        end 
      end 
    else 
      @nome_pess = 'Sem pessoas cadastrados neste atendimento' 
    end
  end 
  # GET /cadastro_atendimentos/new
  def new
    @cadastro_atendimento = CadastroAtendimento.new  
    @cadastro_atendimento.build_filiado  
    options_for_select
    @local = 'Cadastro atendimento >> Novo'
    @acao = 'Novo' 
    @a = 0
  end

  # GET /cadastro_atendimentos/1/edit
  def edit  
    possui_processo
    options_for_select
    @local = 'Cadastro atendimento >> Editar'
    @acao = 'Editar'
  end

  # POST /cadastro_atendimentos
  # POST /cadastro_atendimentos.json
  def create
    options_for_select
    @cadastro_atendimento = CadastroAtendimento.new(cadastro_atendimento_params)  
    respond_to do |format|
      if @cadastro_atendimento.save  
        format.html { redirect_to @cadastro_atendimento, notice: 'Atendimento criado com sucesso.' }
        format.json { render :show, status: :created, location: @cadastro_atendimento } 
      else
        format.html { render :new }
        format.json { render json: @cadastro_atendimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cadastro_atendimentos/1
  # PATCH/PUT /cadastro_atendimentos/1.json
  def update
    options_for_select
    respond_to do |format| 
      if @cadastro_atendimento.update(cadastro_atendimento_params)
        format.html { redirect_to @cadastro_atendimento, notice: 'Atendimento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @cadastro_atendimento }
      else
        format.html { render :edit }
        format.json { render json: @cadastro_atendimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cadastro_atendimentos/1
  # DELETE /cadastro_atendimentos/1.json
  def exluir_processo
    Processo.all.each do |proc|
      if proc.cadastro_atendimento_id == @cadastro_atendimento.id
        return proc.destroy
      end
    end
  end
  def exluir_advogados
    Advogado.all.each do |advogados|
      if advogados.cadastro_atendimento_id == @cadastro_atendimento.id
        return advogados.destroy
      end
    end
  end
  def exluir_pessoas
    Pessoa.all.each do |pessoas|
      if pessoas.cadastro_atendimento_id == @cadastro_atendimento.id
        return pessoas.destroy
      end
    end
  end
  def possui_processo
    Processo.all.each do |processo|
      if processo.cadastro_atendimento_id == @cadastro_atendimento.id
        @possui_processo = true
      else
        @possui_processo = false
      end
    end
  end 
  def exluir_documentos
    Documento.all.each do |documento|
      if documento.cadastro_atendimento_id == @cadastro_atendimento.id
        return documento.destroy
      end
    end
  end 
  def destroy  
    if current_user.email == @restrito_tela_agenda_atividade.usuario || user.admin? 
      exluir_processo
      exluir_advogados
      exluir_pessoas  
      exluir_documentos 
      @cadastro_atendimento.destroy
      respond_to do |format|
        format.html {redirect_to cadastro_atendimentos_url, notice: 'Atendimento foi deletado com sucesso.' }
        format.json { head :no_content }
      end
    end
  end
  ATTRIBUTE_TYPES = {
        texto_livre: TrixField
    }
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cadastro_atendimento
      @cadastro_atendimento = CadastroAtendimento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cadastro_atendimento_params
      params.require(:cadastro_atendimento).permit( :tipo_processo,:data_atendimento, :status, :codigo_tj_filiado, :texto_livre, :nome, :cpf, :telefone, :id , :usuario,:update_objt,
      filiado_attributes: [:cnpj, :end_completo,:titular,:cei, :serventia, :codigo_cnpj, :nome, :cep, :logradouro, :numero_casa, :complemento, :bairro, :telefone_fixo_casa, :cidade_integer, :email, :id],
      advogados_attributes: [:nome, :endereço, :cidade, :bairro, :cep, :telefone, :cidade, :email, :advogado, :oab, :telefone, :observação, :cadastro_atendimento_id, :_destroy, :id],
      pessoas_attributes: [:nome, :profissao, :cep, :razao_social, :nome_fantasia, :cidade, :endereço, :cpf, :rg, :pis, :residencial, :comercial, :celular, :nacionalidade, :estado_civil, :estado_civil, :bairro, :email, :escolaridade, :insc_estadual, :insc_municipal, :responsável, :cnpj, :cadastro_atendimento_id, :_destroy, :id],
      processos_attributes: [:status_processo, :area_atuacao, :objeto_acao, :assunto, :detalhe, :pasta, :etiqueta, :favorito, :local_tramite_um, :local_tramite_dois,:id, :cadastro_atendimento_id,:_destroy , :usuario,:update_objt], 
      documentos_attributes: [:documento],
      assunto_atendimentos_attributes: [:assunto, :descricao , :usuario,:update_objt])
    end
end
