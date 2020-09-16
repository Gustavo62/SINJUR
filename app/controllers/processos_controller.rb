class ProcessosController < ApplicationController
  layout 'restrito'
  before_action :set_processo, only: [:show, :edit, :update, :destroy]

  # GET /processos
  # GET /processos.json
  def index
    if params[:n_processo] or params[:status] or params[:favorito] or params[:intervalo_atend]
      if params[:n_processo] != "" 
        @processo_aux = Processo.where(id: params[:n_processo]).page(params[:page]).per(21)
      else
        if params[:status] != "Todos"
          if params[:favorito]
            if params[:intervalo_atend] != ""
              @processo_aux = Processo.where(status_processo: params[:status],favorito: params[:favorito],created_at: procura_proc_data).page(params[:page]).per(21)
            else
              @processo_aux = Processo.where(status_processo: params[:status],favorito: params[:favorito]).page(params[:page]).per(21)
            end
          else
            if params[:intervalo_atend] != ""
              if params[:favorito]
                @processo_aux = Processo.where(status_processo: params[:status],favorito: params[:favorito],created_at: procura_proc_data).page(params[:page]).per(21)
              else
                @processo_aux = Processo.where(status_processo: params[:status],created_at: procura_proc_data).page(params[:page]).per(21)
              end
            else
              @processo_aux = Processo.where(status_processo: params[:status]).page(params[:page]).per(21)
            end
          end
        else
          if params[:favorito]
            if params[:intervalo_atend] != ""
              @processo_aux = Processo.where(favorito: params[:favorito],created_at: procura_proc_data).page(params[:page]).per(21)
            else
              @processo_aux = Processo.where(favorito: params[:favorito]).page(params[:page]).per(21)
            end
          else
            if params[:intervalo_atend] != ""
              if params[:favorito]
                @processo_aux = Processo.where(favorito: params[:favorito],created_at: procura_proc_data).page(params[:page]).per(21)
              else
                @processo_aux = Processo.where(created_at: procura_proc_data).page(params[:page]).per(21)
              end
            else
              @processo_aux = Processo.page(params[:page]).per(21)
            end
          end
        end
      end
    else
      @processo_aux = Processo.page(params[:page]).per(21)
    end
    @local = 'Processos > Listar Processos'
  end
  # GET /processos/1
  # GET /processos/1.json
  def show
  end
  def procura_proc_data 
    Processo.all.each do |processos|
      if processos.created_at.strftime("%F") == params[:intervalo_atend]
        return processos.created_at.all_day
      end
    end
  end
  # GET /processos/new
  def new
    @processo = Processo.new
  end

  # GET /processos/1/edit
  def edit
  end

  # POST /processos
  # POST /processos.json
  def create
    @processo = Processo.new(processo_params)

    respond_to do |format|
      if @processo.save
        format.html { redirect_to @processo}
        format.json { render :show, status: :created, location: @processo }
      else
        format.html { render :new }
        format.json { render json: @processo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /processos/1
  # PATCH/PUT /processos/1.json
  def update
    respond_to do |format|
      if @processo.update(processo_params)
        format.html { redirect_to @processo}
        format.json { render :show, status: :ok, location: @processo }
      else
        format.html { render :edit }
        format.json { render json: @processo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /processos/1
  # DELETE /processos/1.json
  def destroy
    @processo.destroy
    respond_to do |format|
      format.html { redirect_to processos_url, notice: 'Processo excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  ATTRIBUTE_TYPES = {
        detalhe: TrixField
    }
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_processo
      @processo = Processo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def processo_params
      params.require(:processo).permit(:status_processo, :area_atuacao, :objeto_acao, :assunto, :detalhe, :pasta, :etiqueta, :favorito, :local_tramite_um, :local_tramite_dois, :cadastro_atendimento_id , :usuario)
    end
end
