class Restrito::TelaConsultaController < ApplicationController
  layout 'restrito' 
  def index 
    @solicitantes = Solicitante.all
  end
end
