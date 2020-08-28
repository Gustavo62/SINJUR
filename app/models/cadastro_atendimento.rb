class CadastroAtendimento < ApplicationRecord
    has_one :solicitante
    has_one :filiado 
    has_one :assunto_atendimento
    has_one :action_text_rich_texts
    has_many :advogados
    has_many :pessoas 
    has_many :processos
    has_rich_text  :texto_livre
    has_many :documentos
    has_many_attached :active_storage_blobs
    accepts_nested_attributes_for :advogados,:pessoas, :documentos, :processos,reject_if: :all_blank, allow_destroy: true 
    accepts_nested_attributes_for :solicitante  
    accepts_nested_attributes_for :filiado
    accepts_nested_attributes_for :action_text_rich_texts 
    validates :data_atendimento,:nome, :codigo_tj_filiado, presence: true  
    validates :cpf,:telefone, numericality: { only_integer: true }
    
end