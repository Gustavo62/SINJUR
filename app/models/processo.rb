class Processo < ApplicationRecord
  belongs_to :cadastro_atendimento 
  has_one :action_text_rich_texts
  accepts_nested_attributes_for :action_text_rich_texts 
  validates :area_atuacao,:objeto_acao,:assunto,:pasta,:etiqueta, :local_tramite_um, presence: true  
end
