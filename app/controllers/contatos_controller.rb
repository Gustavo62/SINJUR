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
    @local = "Contatos >> Visualizar"
    @a= 0
  end

  # GET /contatos/new
  def new
    @contato = Contato.new
    @local = "Contatos >> Novo"
    @acao = "Novo"
  end

  # GET /contatos/1/edit
  def edit 
    @local = "Contatos >> Editar"
  end

  # POST /contatos
  # POST /contatos.json
  def create
    @contato = Contato.new(contato_params) 
    respond_to do |format|
      if @contato.save
        format.html { redirect_to @contato, notice: 'Contato foi cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @contato }
      else
        format.html { render :new }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contatos/1
  # PATCH/PUT /contatos/1.json
  def update
    respond_to do |format|
      if @contato.update(contato_params)
        format.html { redirect_to @contato, notice: 'Contato foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @contato }
      else
        format.html { render :edit }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contatos/1
  # DELETE /contatos/1.json
  def exluir_telefone
    Telefone.all.each do |telefones|
      if telefones.contato_id == @contato.id
        return telefones.destroy
      end
    end
  end
  def destroy 
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
      params.require(:contato).permit(:nome, :profissao, :detalhe, :logradouro, :bairro, :cidade, :observacao, :dn, :email, :site, :cep, :numero, :cidade,
      telefones_attributes: [:telefone, :contato_id, :id,:_destroy])
    end
end
