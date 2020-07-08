class Filiado < ApplicationRecord
    has_one :tabeliao
    accepts_nested_attributes_for :tabeliao
    validates :nome, :cidade,:email,presence: true

    validates :cep,:cei,:serventia,:cnpj, numericality: { only_integer: true }
end
