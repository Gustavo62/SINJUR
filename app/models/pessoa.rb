class Pessoa < ApplicationRecord
  belongs_to :cadastro_atendimento
  validates :nome, :cidade, :email, :celular, :estado_civil,presence: true  
end
