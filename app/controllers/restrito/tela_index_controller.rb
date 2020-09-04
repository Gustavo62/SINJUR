class Restrito::TelaIndexController < ApplicationController
  layout 'restrito' 
  def index  
    @cadastro_atendimentos = CadastroAtendimento.all
    
  end
end
