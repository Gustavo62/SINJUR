class ContatosController < ApplicationController
  layout 'restrito'
  before_action :set_contato, only: [:show, :edit, :update, :destroy] 
  @nome_controler = "Contato"
  # GET /contatos
  # GET /contatos.json
  def index
    if params[:cidade] or params[:email]
      if params[:cidade] != "" && params[:email] != ""
        @contatos_aux = Contato.where(cidade: params[:cidade],email: params[:email]).page(params[:page]).per(20)
      else
        if params[:cidade] != ""
          @contatos_aux = Contato.where(cidade: params[:cidade]).page(params[:page]).per(20)
        else
          if params[:email] != ""
            @contatos_aux = Contato.where(email: params[:email]).page(params[:page]).per(20)
          else
            @contatos_aux = Contato.page(params[:page]).per(10)
          end
        end
      end
    else
      @contatos_aux = Contato.page(params[:page]).per(20)
    end
    @contatos = Contato.page(params[:page]).per(20)
    @local = "Contatos" 
  end

  # GET /contatos/1
  # GET /contatos/1.json
  def show
    @local = "Contatos > Visualizar"
    @a= 0
  end

  # GET /contatos/new
  def new
    @contato = Contato.new
    @historico = Historico.new
    @local = "Contatos > Novo"
    @acao = "Novo"
  end

  # GET /contatos/1/edit
  def edit 
    @local = "Contatos > Editar"
  end

  # POST /contatos
  # POST /contatos.json
  def create
    @contato = Contato.new(contato_params) 
    @contato.usuario = current_admin.email
    @contato.update_objt = current_admin.email
    respond_to do |format|
      if @contato.save
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>@contato.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@contato.created_at.strftime('%d'), "hracao(2i)"=>@contato.created_at.strftime('%m'), "hracao(1i)"=>@contato.created_at.strftime('%Y'), "hracao(4i)"=>((@contato.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@contato.created_at.strftime('%M'),"usuario"=>@contato.usuario, "acao_desc"=>"Adicionou um contato, nome do contato: #{@contato.nome}","acao"=>"Adicionou", "objeto"=>"Contato", "quem"=>@contato.usuario) 
        @historico.save 
        format.html { redirect_to @contato, notice: 'Contato foi cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @contato }
      else
        format.html { render :new }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
      if @contato.telefones
        @contato.telefones.each do |telefone|
          telefone.usuario = current_admin.email
          telefone.update_objt = current_admin.email 
          @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>telefone.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>telefone.created_at.strftime('%d'), "hracao(2i)"=>telefone.created_at.strftime('%m'), "hracao(1i)"=>telefone.created_at.strftime('%Y'), "hracao(4i)"=>((telefone.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>telefone.created_at.strftime('%M'),"usuario"=>telefone.usuario, "acao_desc"=>"Adicionou um telefone para o contato id: #{@contato.id}, numero do telefone: #{telefone.telefone}","acao"=>"Adicionou", "objeto"=>"Telefone", "quem"=>telefone.usuario) 
          @historico.save
          @contato.save
        end
      end
    end
  end

  # PATCH/PUT /contatos/1
  # PATCH/PUT /contatos/1.json
  def update
    @contato.update_objt = current_admin.email
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@contato.update_objt,"acaoupdt"=>"Atualizou as informações do contato, nome do contato: #{@contato.nome}" ,"objeto_id"=>@contato.id, "hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@contato.created_at.strftime('%d'), "hracao(2i)"=>@contato.created_at.strftime('%m'), "hracao(1i)"=>@contato.created_at.strftime('%Y'), "hracao(4i)"=>((@contato.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@contato.created_at.strftime('%M'),"usuario"=>@contato.usuario, "acao_desc"=>"Adicionou um contato, nome do contato: #{@contato.nome}","acao"=>"Atualizou", "objeto"=>"Contato", "quem"=>@contato.update_objt) 
    @historico.save
    respond_to do |format|
      if @contato.update(contato_params) 
        format.html { redirect_to @contato, notice: 'Contato foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @contato }
      else
        format.html { render :edit }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end 
    end
    if @contato.telefones
      @contato.telefones.each do |telefone|
        if telefone.changed?
          telefone.update_objt = current_admin.email  
          @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>telefone.update_objt, "acaoupdt"=>"Atualizou um telefone do contato id: #{@contato.id}, numero do telefone: #{telefone.telefone}", "objeto_id"=>telefone.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>telefone.created_at.strftime('%d'), "hracao(2i)"=>telefone.created_at.strftime('%m'), "hracao(1i)"=>telefone.created_at.strftime('%Y'), "hracao(4i)"=>((telefone.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>telefone.created_at.strftime('%M'),"usuario"=>telefone.usuario, "acao_desc"=>"Adicionou um telefone para o contato id: #{@contato.id}, numero do telefone: #{telefone.telefone}","acao"=>"Atualizou", "objeto"=>"Telefone", "quem"=>telefone.update_objt)
          @historico.save 
          
        end
      end
    end 
    @contato.save
  end

  # DELETE /contatos/1
  # DELETE /contatos/1.json
  def exluir_telefone
    Telefone.all.each do |telefone|
      if telefone.contato_id == @contato.id  
        return telefone.destroy
      end
    end
  end
  def destroy   
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@contato.update_objt,"acaoupdt"=>"Excluiu um contato, nome do contato: #{@contato.nome}" ,"objeto_id"=>@contato.id, "hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@contato.created_at.strftime('%d'), "hracao(2i)"=>@contato.created_at.strftime('%m'), "hracao(1i)"=>@contato.created_at.strftime('%Y'), "hracao(4i)"=>((@contato.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@contato.created_at.strftime('%M'),"usuario"=>@contato.usuario, "acao_desc"=>"Adicionou um contato, nome do contato: #{@contato.nome}","acao"=>"Excluiu", "objeto"=>"Contato", "quem"=>@contato.update_objt) 
    @historico.save
    @contato.telefones.each do |telefone| 
      telefone.update_objt = current_admin.email  
      @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>telefone.update_objt, "acaoupdt"=>"Excluiu um telefone do contato id: #{@contato.id}, numero do telefone: #{telefone.telefone}", "objeto_id"=>telefone.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>telefone.created_at.strftime('%d'), "hracao(2i)"=>telefone.created_at.strftime('%m'), "hracao(1i)"=>telefone.created_at.strftime('%Y'), "hracao(4i)"=>((telefone.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>telefone.created_at.strftime('%M'),"usuario"=>telefone.usuario, "acao_desc"=>"Adicionou um telefone para o contato id: #{@contato.id}, numero do telefone: #{telefone.telefone}","acao"=>"Excluiu", "objeto"=>"Telefone", "quem"=>telefone.update_objt)
      @historico.save
      @contato.save 
    end
    exluir_telefone 
    @contato.destroy  
    respond_to do |format|
      format.html { redirect_to contatos_url, notice: 'Contato foi deletado com sucesso.' }
      format.json { head :no_content } 
    end 
  end 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contato
      @contato = Contato.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contato_params
      params.require(:contato).permit(:nome, :profissao, :detalhe, :logradouro, :bairro, :cidade, :observacao, :dn, :email, :site, :cep, :numero, :cidade,:update_objt, :usuario,:quem_username,
      telefones_attributes: [:telefone, :contato_id, :id,:_destroy , :usuario,:update_objt,:quem_username])
    end 
    private 
    
end
