class Pessoa < ApplicationRecord
  belongs_to :cadastro_atendimento
  validates :nome, :cidade, :email, :celular, :estado_civil,presence: true 
  validates :cpf, :rg, :pis,:cep,:celular, numericality: { only_integer: true }
end
