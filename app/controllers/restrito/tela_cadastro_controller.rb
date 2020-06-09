class Restrito::TelaCadastroController < ApplicationController
  layout 'restrito' 
  def index
    @solicitantes = Solicitante.all
    @cadastro_atendimento.build_solicitante
  end
end
