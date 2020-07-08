class Processo < ApplicationRecord
  belongs_to :cadastro_atendimento 
  validates :area_atuacao,:objeto_acao,:assunto,:pasta,:etiqueta, :local_tramite_um, presence: true  
end
