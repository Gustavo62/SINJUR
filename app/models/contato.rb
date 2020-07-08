class Contato < ApplicationRecord 
    has_many :telefones
    accepts_nested_attributes_for :telefones, reject_if: :all_blank,allow_destroy: true 
    validates :nome,:email,:profissao, presence: true
    validates :cep, numericality: { only_integer: true }
end
