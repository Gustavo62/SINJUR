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
    @local = 'Cadastro atendimento > Listar Atendimento'
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
  def possui_processo
    Processo.all.each do |processo|
      if processo.cadastro_atendimento_id == @cadastro_atendimento.id
        @possui_processo = true
      else
        @possui_processo = false
      end
    end
  end 
    # GET /cadastro_atendimentos/1
  # GET /cadastro_atendimentos/1.json
  def show
    @local = 'Cadastro atendimento > Visualizar'
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
    @local = 'Cadastro atendimento > Novo'
    @acao = 'Novo' 
    @a = 0
  end

  # GET /cadastro_atendimentos/1/edit
  def edit  
    possui_processo
    options_for_select
    @local = 'Cadastro atendimento > Editar'
    @acao = 'Editar'
  end

  # POST /cadastro_atendimentos
  # POST /cadastro_atendimentos.json
  def create
    options_for_select
    @cadastro_atendimento = CadastroAtendimento.new(cadastro_atendimento_params)  
    @cadastro_atendimento.usuario = current_admin.email
    @cadastro_atendimento.update_objt = current_admin.email
    
    respond_to do |format|
      if @cadastro_atendimento.save
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>@cadastro_atendimento.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@cadastro_atendimento.created_at.strftime('%d'), "hracao(2i)"=>@cadastro_atendimento.created_at.strftime('%m'), "hracao(1i)"=>@cadastro_atendimento.created_at.strftime('%Y'), "hracao(4i)"=>((@cadastro_atendimento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@cadastro_atendimento.created_at.strftime('%M'),"usuario"=>@cadastro_atendimento.usuario, "acao_desc"=>"Adicionou um atendimento, nome do cliente: #{@cadastro_atendimento.nome}","acao"=>"Adicionou", "objeto"=>"Atendimento", "quem"=>@cadastro_atendimento.usuario) 
        @historico.save
        format.html { redirect_to @cadastro_atendimento, notice: 'Atendimento criado com sucesso.' }
        format.json { render :show, status: :created, location: @cadastro_atendimento } 
        if @cadastro_atendimento.pessoas
          @cadastro_atendimento.pessoas.each do |pessoa|
            pessoa.usuario = current_admin.email
            pessoa.update_objt = current_admin.email 
            @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>pessoa.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>pessoa.created_at.strftime('%d'), "hracao(2i)"=>pessoa.created_at.strftime('%m'), "hracao(1i)"=>pessoa.created_at.strftime('%Y'), "hracao(4i)"=>((pessoa.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>pessoa.created_at.strftime('%M'),"usuario"=>pessoa.usuario, "acao_desc"=>"Adicionou uma pessoa ao atendimento id:#{@cadastro_atendimento.id}, nome: #{pessoa.nome}","acao"=>"Adicionou", "objeto"=>"Pessoa", "quem"=>pessoa.usuario) 
            @historico.save 
          end
        end
        if @cadastro_atendimento.advogados
          @cadastro_atendimento.advogados.each do |advogado|
            advogado.usuario = current_admin.email
            advogado.update_objt = current_admin.email 
            @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>advogado.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>advogado.created_at.strftime('%d'), "hracao(2i)"=>advogado.created_at.strftime('%m'), "hracao(1i)"=>advogado.created_at.strftime('%Y'), "hracao(4i)"=>((advogado.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>advogado.created_at.strftime('%M'),"usuario"=>advogado.usuario, "acao_desc"=>"Adicionou um advogado ao atendimento id:#{@cadastro_atendimento.id}, nome: #{advogado.nome}","acao"=>"Adicionou", "objeto"=>"Advogado", "quem"=>advogado.usuario) 
            @historico.save
          end
        end
        if @cadastro_atendimento.processos
          @cadastro_atendimento.processos.each do |processo|
            processo.usuario = current_admin.email
            processo.update_objt = current_admin.email 
            @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>processo.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>processo.created_at.strftime('%d'), "hracao(2i)"=>processo.created_at.strftime('%m'), "hracao(1i)"=>processo.created_at.strftime('%Y'), "hracao(4i)"=>((processo.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>processo.created_at.strftime('%M'),"usuario"=>processo.usuario, "acao_desc"=>"Adicionou um processo ao atendimento id:#{@cadastro_atendimento.id}, etiqueta: #{processo.etiqueta}","acao"=>"Adicionou", "objeto"=>"Processo", "quem"=>processo.usuario) 
            @historico.save
          end
        end 
        if @cadastro_atendimento.documentos
          @cadastro_atendimento.documentos.each do |documento|
            documento.usuario = current_admin.email
            documento.update_objt = current_admin.email 
            @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>documento.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>documento.created_at.strftime('%d'), "hracao(2i)"=>documento.created_at.strftime('%m'), "hracao(1i)"=>documento.created_at.strftime('%Y'), "hracao(4i)"=>((documento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>documento.created_at.strftime('%M'),"usuario"=>documento.usuario, "acao_desc"=>"Adicionou um documento ao atendimento id:#{@cadastro_atendimento.id}, descrição: #{documento.descricao}","acao"=>"Adicionou", "objeto"=>"Documento", "quem"=>documento.usuario) 
            @historico.save
          end
        end
      else
        format.html { render :new }
        format.json { render json: @cadastro_atendimento.errors, status: :unprocessable_entity }
      end
      
    end
  end
  ATTRIBUTE_TYPES = {
    texto_livre: TrixField
    }
  # PATCH/PUT /cadastro_atendimentos/1
  # PATCH/PUT /cadastro_atendimentos/1.json
  def update
    @cadastro_atendimento.update_objt = current_admin.email
    options_for_select
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@cadastro_atendimento.update_objt,"acaoupdt"=>"Atualizou as informações do atendimento, nome do cliente: #{@cadastro_atendimento.nome}" ,"objeto_id"=>@cadastro_atendimento.id, "hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@cadastro_atendimento.created_at.strftime('%d'), "hracao(2i)"=>@cadastro_atendimento.created_at.strftime('%m'), "hracao(1i)"=>@cadastro_atendimento.created_at.strftime('%Y'), "hracao(4i)"=>((@cadastro_atendimento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@cadastro_atendimento.created_at.strftime('%M'),"usuario"=>@cadastro_atendimento.usuario, "acao_desc"=>"Adicionou um atendimento, nome do cliente: #{@cadastro_atendimento.nome}","acao"=>"Atualizou", "objeto"=>"Atendimento", "quem"=>@cadastro_atendimento.update_objt) 
    @historico.save 
    respond_to do |format| 
      if @cadastro_atendimento.update(cadastro_atendimento_params)    
        if @cadastro_atendimento.pessoas
          @cadastro_atendimento.pessoas.each do |pessoa|
            if pessoa.changed?
              pessoa.update_objt = current_admin.email 
              @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>pessoa.update_objt, "acaoupdt"=>"Atualizou as informações de uma pessoa ao atendimento id:#{@cadastro_atendimento.id}, nome: #{pessoa.nome}", "objeto_id"=>pessoa.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>pessoa.created_at.strftime('%d'), "hracao(2i)"=>pessoa.created_at.strftime('%m'), "hracao(1i)"=>pessoa.created_at.strftime('%Y'), "hracao(4i)"=>((pessoa.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>pessoa.created_at.strftime('%M'),"usuario"=>pessoa.usuario, "acao_desc"=>"Adicionou uma pessoa, nome: #{pessoa.nome}","acao"=>"Atualizou", "objeto"=>"Pessoa", "quem"=>pessoa.update_objt) 
              @historico.save 
            end
          end
        end
        if @cadastro_atendimento.advogados
          @cadastro_atendimento.advogados.each do |advogado|
            if advogado.changed?
              advogado.update_objt = current_admin.email 
              @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>advogado.update_objt,"acaoupdt"=>"Atualizou as informações do advogado ao atendimento id:#{@cadastro_atendimento.id}, nome: #{advogado.nome}" ,"objeto_id"=>advogado.id, "hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>advogado.created_at.strftime('%d'), "hracao(2i)"=>advogado.created_at.strftime('%m'), "hracao(1i)"=>advogado.created_at.strftime('%Y'), "hracao(4i)"=>((advogado.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>advogado.created_at.strftime('%M'),"usuario"=>advogado.usuario, "acao_desc"=>"Adicionou um advogado, nome: #{advogado.nome}","acao"=>"Atualizou", "objeto"=>"Advogado", "quem"=>advogado.update_objt) 
              @historico.save
            end 
          end
        end
        if @cadastro_atendimento.processos
          @cadastro_atendimento.processos.each do |processo|
            if processo.changed?
              processo.update_objt = current_admin.email 
              @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>processo.update_objt, "acaoupdt"=>"Atualizou um processo ao atendimento id:#{@cadastro_atendimento.id}, etiqueta: #{processo.etiqueta}", "objeto_id"=>processo.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>processo.created_at.strftime('%d'), "hracao(2i)"=>processo.created_at.strftime('%m'), "hracao(1i)"=>processo.created_at.strftime('%Y'), "hracao(4i)"=>((processo.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>processo.created_at.strftime('%M'),"usuario"=>processo.usuario, "acao_desc"=>"Adicionou um processo, etiqueta: #{processo.etiqueta}","acao"=>"Atualizou", "objeto"=>"Processo", "quem"=>processo.update_objt) 
              @historico.save 
            end
          end
        end
        if @cadastro_atendimento.documentos
          @cadastro_atendimento.documentos.each do |documento|
            if documento.changed?
              documento.update_objt = current_admin.email 
              @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>documento.update_objt, "acaoupdt"=>"Atualizou um documento ao atendimento id:#{@cadastro_atendimento.id}, descricao: #{documento.descricao}", "objeto_id"=>documento.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>documento.created_at.strftime('%d'), "hracao(2i)"=>documento.created_at.strftime('%m'), "hracao(1i)"=>documento.created_at.strftime('%Y'), "hracao(4i)"=>((documento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>documento.created_at.strftime('%M'),"usuario"=>documento.usuario, "acao_desc"=>"Adicionou um documento, descrição: #{documento.descricao}","acao"=>"Atualizou", "objeto"=>"Documento", "quem"=>documento.update_objt) 
              @historico.save
            end
          end
        end
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
        proc.update_objt = current_admin.email
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>proc.update_objt, "acaoupdt"=>"Excluiu um processo do atendimento id:#{@cadastro_atendimento.id}, etiqueta: #{proc.etiqueta}", "objeto_id"=>proc.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>proc.created_at.strftime('%d'), "hracao(2i)"=>proc.created_at.strftime('%m'), "hracao(1i)"=>proc.created_at.strftime('%Y'), "hracao(4i)"=>((proc.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>proc.created_at.strftime('%M'),"usuario"=>proc.usuario, "acao_desc"=>"Adicionou um processo, etiqueta: #{proc.etiqueta}","acao"=>"Excluiu", "objeto"=>"Processo", "quem"=>proc.update_objt) 
        @historico.save 
      end
    end
    Processo.all.each do |proc|
      if proc.cadastro_atendimento_id == @cadastro_atendimento.id 
        return proc.destroy
      end
    end
  end
  def exluir_advogados
    Advogado.all.each do |advogados|
      if advogados.cadastro_atendimento_id == @cadastro_atendimento.id 
        advogados.update_objt = current_admin.email 
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>advogados.update_objt,"acaoupdt"=>"Excluiu as informações do advogado do atendimento id:#{@cadastro_atendimento.id}, nome: #{advogados.nome}" ,"objeto_id"=>advogados.id, "hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>advogados.created_at.strftime('%d'), "hracao(2i)"=>advogados.created_at.strftime('%m'), "hracao(1i)"=>advogados.created_at.strftime('%Y'), "hracao(4i)"=>((advogados.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>advogados.created_at.strftime('%M'),"usuario"=>advogados.usuario, "acao_desc"=>"Adicionou um advogado, nome: #{advogados.nome}","acao"=>"Excluiu", "objeto"=>"Advogado", "quem"=>advogados.update_objt) 
        @historico.save 
      end
    end
    Advogado.all.each do |advogados|
      if advogados.cadastro_atendimento_id == @cadastro_atendimento.id 
        return advogados.destroy
      end
    end
  end
  def exluir_pessoas
    Pessoa.all.each do |pessoas|
      if pessoas.cadastro_atendimento_id == @cadastro_atendimento.id
        pessoas.update_objt = current_admin.email 
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>pessoas.update_objt, "acaoupdt"=>"Excluiu uma pessoa do atendimento id:#{@cadastro_atendimento.id}, nome: #{pessoas.nome}", "objeto_id"=>pessoas.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>pessoas.created_at.strftime('%d'), "hracao(2i)"=>pessoas.created_at.strftime('%m'), "hracao(1i)"=>pessoas.created_at.strftime('%Y'), "hracao(4i)"=>((pessoas.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>pessoas.created_at.strftime('%M'),"usuario"=>pessoas.usuario, "acao_desc"=>"Adicionou uma pessoa, nome: #{pessoas.nome}","acao"=>"Excluiu", "objeto"=>"Pessoa", "quem"=>pessoas.update_objt) 
        @historico.save 
      end
    end
    Pessoa.all.each do |pessoas|
      if pessoas.cadastro_atendimento_id == @cadastro_atendimento.id
        return pessoas.destroy
      end
    end
  end
  
  def exluir_documentos
    Documento.all.each do |documento|
      if documento.cadastro_atendimento_id == @cadastro_atendimento.id 
        documento.update_objt = current_admin.email  
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>current_admin.email, "acaoupdt"=>"Excluiu o documento do atendimento id:#{@cadastro_atendimento.id}, descricao: #{documento.descricao}", "objeto_id"=>documento.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M') , "hracao(3i)"=>documento.created_at.strftime('%d'), "hracao(2i)"=>documento.created_at.strftime('%m'), "hracao(1i)"=>documento.created_at.strftime('%Y'), "hracao(4i)"=>((documento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>documento.created_at.strftime('%M'),"usuario"=>documento.usuario, "acao_desc"=>"Adicionou um documento ao atendimento id:#{@cadastro_atendimento.id}, descrição: #{documento.descricao}","acao"=>"Excluiu", "objeto"=>"Documento", "quem"=>documento.update_objt) 
        @historico.save 
      end
    end 
    Documento.all.each do |documento|
      if documento.cadastro_atendimento_id == @cadastro_atendimento.id 
        return documento.destroy
      end
    end 
  end 
  def destroy  
     
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@cadastro_atendimento.update_objt,"acaoupdt"=>"Excluiu as informações do atendimento, nome do cliente: #{@cadastro_atendimento.nome}" ,"objeto_id"=>@cadastro_atendimento.id, "hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@cadastro_atendimento.created_at.strftime('%d'), "hracao(2i)"=>@cadastro_atendimento.created_at.strftime('%m'), "hracao(1i)"=>@cadastro_atendimento.created_at.strftime('%Y'), "hracao(4i)"=>((@cadastro_atendimento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@cadastro_atendimento.created_at.strftime('%M'),"usuario"=>@cadastro_atendimento.usuario, "acao_desc"=>"Adicionou um atendimento, nome do cliente: #{@cadastro_atendimento.nome}","acao"=>"Excluiu", "objeto"=>"Atendimento", "quem"=>@cadastro_atendimento.update_objt) 
    @historico.save  
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

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cadastro_atendimento
      @cadastro_atendimento = CadastroAtendimento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cadastro_atendimento_params
      params.require(:cadastro_atendimento).permit( :tipo_processo,:data_atendimento, :status, :codigo_tj_filiado, :texto_livre, :nome, :cpf, :telefone, :id , :usuario,:update_objt,:quem_username,
      filiado_attributes: [:cnpj, :end_completo,:titular,:cei, :serventia, :codigo_cnpj, :nome, :cep, :logradouro, :numero_casa, :complemento, :bairro, :telefone_fixo_casa, :cidade_integer, :email, :id,:update_objt, :usuario,:quem_username],
      advogados_attributes: [:nome, :endereço, :cidade, :bairro, :cep, :telefone, :cidade, :email, :advogado, :oab, :telefone, :observação, :cadastro_atendimento_id, :_destroy, :id,:update_objt, :usuario,:quem_username],
      pessoas_attributes: [:nome, :profissao, :cep, :razao_social, :nome_fantasia, :cidade, :endereço, :cpf, :rg, :pis, :residencial, :comercial, :celular, :nacionalidade, :estado_civil, :estado_civil, :bairro, :email, :escolaridade, :insc_estadual, :insc_municipal, :responsável, :cnpj, :cadastro_atendimento_id, :_destroy, :id,:update_objt, :usuario,:quem_username],
      processos_attributes: [:status_processo, :area_atuacao, :objeto_acao, :assunto, :detalhe, :pasta, :etiqueta, :favorito, :local_tramite_um, :local_tramite_dois,:id, :cadastro_atendimento_id,:_destroy , :usuario,:update_objt,:quem_username], 
      documentos_attributes: [:documento,:descricao,:update_objt, :usuario,:quem_username],
      cadastro_atendimentos_attributes: [:assunto, :descricao , :usuario,:update_objt,:quem_username])
    end
end
