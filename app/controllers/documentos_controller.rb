class DocumentosController < ApplicationController
  before_action :set_documento, only: [:show, :edit, :update, :destroy]

  # GET /documentos
  # GET /documentos.json
  def index
    @documentos = Documento.all
    @cadastro_atendimento = CadastroAtendimento.all
  end

  # GET /documentos/1
  # GET /documentos/1.json
  def show
  end

  # GET /documentos/new
  def new
    @documento = Documento.new
  end

  # GET /documentos/1/edit
  def edit
  end

  # POST /documentos
  # POST /documentos.json
  def create
    @documento = Documento.new(documento_params)
    @documento.usuario = current_admin.email
    @documento.update_objt = current_admin.email 

    respond_to do |format|
      if @documento.save
        
        CadastroAtendimento.all.each do |atend|
          if @documento.cadastro_atendimento_id == atend.id
            @documento.update_objt = current_admin.email
            @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>@documento.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@documento.created_at.strftime('%d'), "hracao(2i)"=>@documento.created_at.strftime('%m'), "hracao(1i)"=>@documento.created_at.strftime('%Y'), "hracao(4i)"=>((@documento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@documento.created_at.strftime('%M'),"usuario"=>@documento.usuario, "acao_desc"=>"Adicionou um documento ao atendimento id:#{atend.id}, descrição: #{@documento.descricao}","acao"=>"Adicionou", "objeto"=>"Documento", "quem"=>@documento.usuario) 
            @historico.save 
          end
        end 
        format.html { redirect_to @documento, notice: 'Documento foi cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @documento }
      else
        format.html { render :new }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentos/1
  # PATCH/PUT /documentos/1.json
  def update 
    CadastroAtendimento.all.each do |atend|
      if @documento.cadastro_atendimento_id == atend.id
        @documento.update_objt = current_admin.email
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@documento.update_objt, "acaoupdt"=>"Atualizou um documento do atendimento id:#{atend.id}, descricao: #{@documento.descricao}", "objeto_id"=>@documento.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@documento.created_at.strftime('%d'), "hracao(2i)"=>@documento.created_at.strftime('%m'), "hracao(1i)"=>@documento.created_at.strftime('%Y'), "hracao(4i)"=>((@documento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@documento.created_at.strftime('%M'),"usuario"=>@documento.usuario, "acao_desc"=>"Adicionou um documento ao atendimento id:#{atend.id}, descrição: #{@documento.descricao}","acao"=>"Atualizou", "objeto"=>"Documento", "quem"=>@documento.update_objt) 
        @historico.save 
      end
    end 
    respond_to do |format|
      if @documento.update(documento_params) 
        format.html { redirect_to @documento, notice: 'Documento foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @documento }
      else
        format.html { render :edit }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1
  # DELETE /documentos/1.json
  def destroy
    CadastroAtendimento.all.each do |atend|
      if @documento.cadastro_atendimento_id == atend.id
        @documento.update_objt = current_admin.email
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>current_admin.email, "acaoupdt"=>"Excluiu o documento do atendimento id:#{atend.id}, descricao: #{@documento.descricao}", "objeto_id"=>@documento.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M') , "hracao(3i)"=>@documento.created_at.strftime('%d'), "hracao(2i)"=>@documento.created_at.strftime('%m'), "hracao(1i)"=>@documento.created_at.strftime('%Y'), "hracao(4i)"=>((@documento.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@documento.created_at.strftime('%M'),"usuario"=>@documento.usuario, "acao_desc"=>"Adicionou um documento ao atendimento id:#{atend.id}, descrição: #{@documento.descricao}","acao"=>"Excluiu", "objeto"=>"Documento", "quem"=>@documento.update_objt) 
        @historico.save 
      end
    end 
    @documento.destroy
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documento
      @documento = Documento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def documento_params
      params.require(:documento,:descricao,:update_objt, :usuario,:quem_username).permit(:docs)
    end
end
