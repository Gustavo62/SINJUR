class ContatosController < ApplicationController
  layout 'restrito'
  before_action :set_contato, only: [:show, :edit, :update, :destroy]

  # GET /contatos
  # GET /contatos.json
  def index
    if params[:cidade] or params[:email]
      if params[:cidade] != "" && params[:email] != ""
        @contatos_aux = Contato.where(cidade: params[:cidade],email: params[:email])
      else
        if params[:cidade] != ""
          @contatos_aux = Contato.where(cidade: params[:cidade])
        else
          if params[:email] != ""
            @contatos_aux = Contato.where(email: params[:email])
          else
            @contatos_aux = Contato.all
          end
        end
      end
    else
      @contatos_aux = Contato.all
    end
    @contatos = Contato.all
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
        format.html { redirect_to @contato, notice: 'Contato was successfully created.' }
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
        format.html { redirect_to @contato, notice: 'Contato was successfully updated.' }
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
      format.html { redirect_to contatos_url, notice: 'Contato was successfully destroyed.' }
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
