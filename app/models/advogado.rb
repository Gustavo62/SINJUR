class Advogado < ApplicationRecord
  belongs_to :cadastro_atendimento
  validates :nome, :cidade, :email, :oab,presence: true
   
  validates :cep,:telefone, numericality: { only_integer: true }
end
