class Restrito::TelaAgenda::AtividadesController < ApplicationController
  before_action :set_restrito_tela_agenda_atividade, only: [:show, :edit, :update, :destroy]
  layout 'restrito'
  # GET /restrito/tela_agenda/atividades
  # GET /restrito/tela_agenda/atividades.json
  def index 
    if  params[:agendamento] && params[:tipo] && params[:nivel] 
      if params[:agendamento] != ''
        if params[:nivel] != "Todos"
          if params[:tipo] != "Todos"
            @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.where(nivel: params[:nivel],tipo: params[:tipo],agendamento: params[:agendamento].to_date.all_day).page(params[:page]).per(19)
          else
            @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.where(nivel: params[:nivel],agendamento: params[:agendamento].to_date.all_day).page(params[:page]).per(19)
          end
        else
          if params[:tipo] != "Todos"
            @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.where(tipo: params[:tipo],agendamento: params[:agendamento].to_date.all_day).page(params[:page]).per(19)
          else
            @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.where(agendamento: params[:agendamento].to_date.all_day).page(params[:page]).per(19)
          end
        end
      else
        if params[:nivel] != "Todos"
          if params[:tipo] != "Todos"
            @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.where(nivel: params[:nivel],tipo: params[:tipo]).page(params[:page]).per(19)
          else
            @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.where(nivel: params[:nivel]).page(params[:page]).per(19)
          end
        else
          if params[:tipo] != "Todos"
            @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.where(tipo: params[:tipo]).page(params[:page]).per(19)
          else
            @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.page(params[:page]).per(19)
          end
        end
      end
    else
      @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.page(params[:page]).per(19)
    end
    @local = 'Agenda de Atividades'
  end 
  # GET /restrito/tela_agenda/atividades/1
  # GET /restrito/tela_agenda/atividades/1.json
  def show 
    @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.page(params[:page]).per(19)
    @local = 'Agenda de Atividades > Visualizar'
    def start_time
      self.agendamento 
    end  
  end  
  # GET /restrito/tela_agenda/atividades/new
  def new 
    @restrito_tela_agenda_atividade = Restrito::TelaAgenda::Atividade.new 
    @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.all
    @local = 'Agenda de Atividades > Novo'
    @acao = 'Nova' 
  end

  # GET /restrito/tela_agenda/atividades/1/edit
  def edit 
    @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.all
    @local = 'Agenda de Atividades > Editar'
    @acao = 'Editar'
  end

  # POST /restrito/tela_agenda/atividades
  # POST /restrito/tela_agenda/atividades.json
  def create

    @restrito_tela_agenda_atividades = Restrito::TelaAgenda::Atividade.all
    @restrito_tela_agenda_atividade = Restrito::TelaAgenda::Atividade.new(restrito_tela_agenda_atividade_params)
    @restrito_tela_agenda_atividade.usuario = current_admin.email
    @restrito_tela_agenda_atividade.update_objt = current_admin.email
    respond_to do |format|
      if @restrito_tela_agenda_atividade.save
        @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>"Sem atualização", "acaoupdt"=>"Sem atualização", "objeto_id"=>@restrito_tela_agenda_atividade.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%d'), "hracao(2i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%m'), "hracao(1i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%Y'), "hracao(4i)"=>((@restrito_tela_agenda_atividade.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%M'),"usuario"=>@restrito_tela_agenda_atividade.usuario, "acao_desc"=>"Adicionou uma atividade, titulo: #{@restrito_tela_agenda_atividade.titulo}","acao"=>"Adicionou", "objeto"=>"Atividade", "quem"=>@restrito_tela_agenda_atividade.usuario) 
        @historico.save
        format.html { redirect_to restrito_tela_agenda_atividades_url, notice: 'Atividade foi cadastrada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @restrito_tela_agenda_atividade.errors, status: :unprocessable_entity }
      end
    end
  end 
  # PATCH/PUT /restrito/tela_agenda/atividades/1
  # PATCH/PUT /restrito/tela_agenda/atividades/1.json
  def update
    @restrito_tela_agenda_atividade.update_objt = current_admin.email
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@restrito_tela_agenda_atividade.update_objt, "acaoupdt"=>"Atualizou uma atividade, titulo: #{@restrito_tela_agenda_atividade.titulo}", "objeto_id"=>@restrito_tela_agenda_atividade.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%d'), "hracao(2i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%m'), "hracao(1i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%Y'), "hracao(4i)"=>((@restrito_tela_agenda_atividade.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%M'),"usuario"=>@restrito_tela_agenda_atividade.usuario, "acao_desc"=>"Adicionou uma atividade, titulo: #{@restrito_tela_agenda_atividade.titulo}","acao"=>"Atualizou", "objeto"=>"Atividade", "quem"=>@restrito_tela_agenda_atividade.update_objt) 
    @historico.save
    respond_to do |format|
      if @restrito_tela_agenda_atividade.update(restrito_tela_agenda_atividade_params)
        format.html { redirect_to @restrito_tela_agenda_atividade, notice: 'Atividade foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @restrito_tela_agenda_atividade }
      else
        format.html { render :edit }
        format.json { render json: @restrito_tela_agenda_atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restrito/tela_agenda/atividades/1
  # DELETE /restrito/tela_agenda/atividades/1.json
  def destroy  
    @restrito_tela_agenda_atividade.update_objt = current_admin.email
    @historico = Historico.new("quem_username"=>current_admin.username,"usuarioudt"=>@restrito_tela_agenda_atividade.update_objt, "acaoupdt"=>"Excluiu uma atividade, titulo: #{@restrito_tela_agenda_atividade.titulo}", "objeto_id"=>@restrito_tela_agenda_atividade.id,"hrup(3i)"=>Time.now.strftime('%d'), "hrup(2i)"=>Time.now.strftime('%m'), "hrup(1i)"=>Time.now.strftime('%Y'), "hrup(4i)"=>Time.now.strftime('%H'), "hrup(5i)"=>Time.now.strftime('%M'), "hracao(3i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%d'), "hracao(2i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%m'), "hracao(1i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%Y'), "hracao(4i)"=>((@restrito_tela_agenda_atividade.created_at.strftime('%H').to_i - 3)).to_s, "hracao(5i)"=>@restrito_tela_agenda_atividade.created_at.strftime('%M'),"usuario"=>@restrito_tela_agenda_atividade.usuario, "acao_desc"=>"Adicionou uma atividade, titulo: #{@restrito_tela_agenda_atividade.titulo}","acao"=>"Excluiu", "objeto"=>"Atividade", "quem"=>@restrito_tela_agenda_atividade.update_objt) 
    @historico.save
    @restrito_tela_agenda_atividade.destroy
    respond_to do |format|
      format.html { redirect_to restrito_tela_agenda_atividades_url, notice: 'Atividade foi deletada com sucesso.' }
      format.json { head :no_content }
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restrito_tela_agenda_atividade
      @restrito_tela_agenda_atividade = Restrito::TelaAgenda::Atividade.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restrito_tela_agenda_atividade_params
      params.require(:restrito_tela_agenda_atividade).permit(:tipo, :titulo, :nivel, :resumo, :status, :agendamento , :usuario,:update_objt,:quem_username)
    end
end
