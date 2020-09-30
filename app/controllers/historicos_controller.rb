class HistoricosController < ApplicationController
  layout 'restrito'
  before_action :set_historico, only: [:show, :edit, :update, :destroy]

  # GET /historicos
  # GET /historicos.json
  def index
    if params[:email_hist] or params[:acao_hist] or params[:objt_hist] or params[:dat_hist]
      if params[:email_hist] != ''
        if params[:acao_hist] == 'Todos'
          if params[:objt_hist] == 'Todos'
            if params[:dat_hist] != ''
              @historicos =  Historico.where(quem: params[:email_hist],hracao: procura_data_hist,hrup: procura_data_hist).page(params[:page]).per(20)
            else 
              @historicos =  Historico.where(quem: params[:email_hist]).page(params[:page]).per(20)
            end
          else
            if params[:dat_hist] != ''
              @historicos =  Historico.where(objeto: params[:objt_hist], quem: params[:email_hist],hracao: procura_data_hist,hrup: procura_data_hist).page(params[:page]).per(20)
            else 
              @historicos =  Historico.where(objeto: params[:objt_hist], quem: params[:email_hist]).page(params[:page]).per(20)
            end
          end
        else
          if params[:objt_hist] == 'Todos'
            if params[:dat_hist] != ''
              @historicos =  Historico.where(acao: params[:acao_hist],objeto: params[:objt_hist], quem: params[:email_hist],hracao: procura_data_hist,hrup: procura_data_hist).page(params[:page]).per(20)
            else 
              @historicos =  Historico.where(acao: params[:acao_hist],quem: params[:email_hist]).page(params[:page]).per(20)
            end
          else
            if params[:dat_hist] != ''
              @historicos =  Historico.where(acao: params[:acao_hist],objeto: params[:objt_hist], quem: params[:email_hist],hracao: procura_data_hist,hrup: procura_data_hist).page(params[:page]).per(20)
            else 
              @historicos =  Historico.where(acao: params[:acao_hist],objeto: params[:objt_hist], quem: params[:email_hist]).page(params[:page]).per(20)
            end
          end 
        end
      else
        if params[:acao_hist] == 'Todos'
          if params[:objt_hist] == 'Todos'
            if params[:dat_hist] != ''
              @historicos =  Historico.where(hracao: procura_data_hist,hrup: procura_data_hist).page(params[:page]).per(20)
            else 
              @historicos =  Historico.all.page(params[:page]).per(20)
            end
          else 
            if params[:dat_hist] != ''
              @historicos =  Historico.where(objeto: params[:objt_hist],hracao: procura_data_hist,hrup: procura_data_hist).page(params[:page]).per(20)
            else 
              @historicos =  Historico.where(objeto: params[:objt_hist]).page(params[:page]).per(20)
            end
          end
        else
          if params[:objt_hist] == 'Todos'
            if params[:dat_hist] != ''
              @historicos =  Historico.where(acao: params[:acao_hist],objeto: params[:objt_hist],hracao: procura_data_hist,hrup: procura_data_hist).page(params[:page]).per(20)
            else 
              @historicos =  Historico.where(acao: params[:acao_hist]).page(params[:page]).per(20)
            end
          else
            if params[:dat_hist] != ''
              @historicos =  Historico.where(acao: params[:acao_hist],objeto: params[:objt_hist],hracao: procura_data_hist,hrup: procura_data_hist).page(params[:page]).per(20)
            else 
              @historicos =  Historico.where(acao: params[:acao_hist],objeto: params[:objt_hist]).page(params[:page]).per(20)
            end
          end 
        end
      end
    else
      @historicos = Historico.page(params[:page]).per(20)
    end
    @local = 'Histórico'
  end
  def procura_data_hist
    Historico.all.each do |historico|
      if historico.created_at.strftime("%F") == params[:dat_hist]
        return historico.created_at.all_day
      end
    end
  end
  # GET /historicos/1
  # GET /historicos/1.json
  def show
  end

  # GET /historicos/new
  def new
    @historico = Historico.new
  end

  # GET /historicos/1/edit
  def edit
  end

  # POST /historicos
  # POST /historicos.json
  def create
    @historico = Historico.new(historico_params)

    respond_to do |format|
      if @historico.save
        format.html { redirect_to @historico, notice: 'Historico was successfully created.' }
        format.json { render :show, status: :created, location: @historico }
      else
        format.html { render :new }
        format.json { render json: @historico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historicos/1
  # PATCH/PUT /historicos/1.json
  def update
    respond_to do |format|
      if @historico.update(historico_params)
        format.html { redirect_to @historico, notice: 'Historico was successfully updated.' }
        format.json { render :show, status: :ok, location: @historico }
      else
        format.html { render :edit }
        format.json { render json: @historico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historicos/1
  # DELETE /historicos/1.json
  def destroy 
    @historico.destroy
    respond_to do |format|
      format.html { redirect_to historicos_url, notice: 'Historico was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historico
      @historico = Historico.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def historico_params
      params.require(:historico).permit(:usuarioudt, :acaoupdt, :hracao, :usuario, :acao_desc, :acao , :objeto,:quem,:hrup,:objeto_id,:quem_username)
    end
end
