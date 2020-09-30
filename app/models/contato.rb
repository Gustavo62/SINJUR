class Contato < ApplicationRecord 
    has_many :telefones, :dependent => :destroy
    accepts_nested_attributes_for :telefones, reject_if: :all_blank,allow_destroy: true 
    validates :nome,:email,:profissao, :cep,presence: true 
end
