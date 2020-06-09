class CadastroAtendimento < ApplicationRecord
    has_one :solicitante
    has_one :filiado
    has_one :action_text_rich_texts
    has_many :advogados
    has_many :pessoas 
    has_many :processos
    has_rich_text  :texto_livre
    has_one_attached :documento
    accepts_nested_attributes_for :advogados,:pessoas, reject_if: :all_blank, allow_destroy: true 
    accepts_nested_attributes_for :processos, allow_destroy: true
    accepts_nested_attributes_for :solicitante  
    accepts_nested_attributes_for :filiado
    accepts_nested_attributes_for :action_text_rich_texts

    
end