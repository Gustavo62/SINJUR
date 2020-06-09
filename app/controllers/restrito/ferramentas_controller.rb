class Restrito::FerramentasController < ApplicationController
  layout 'restrito'
  def index
    if params[:cpf] != nil
      @solicitantes_aux = Solicitante.where(cpf: consulta_cpf)
    else
      @solicitantes_aux = Solicitante.all 
    end 
    @solicitantes = Solicitante.all
    options_for_select  
  end
  def consulta_cpf
    Solicitante.all.each do |solicitante|
      if String(solicitante.cpf) == params[:cpf]
        
      end
    end

  end
  def options_for_select
    @filiados_for_select = Filiado.all 
  end 
end
