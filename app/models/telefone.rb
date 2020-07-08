class Telefone < ApplicationRecord  
    belongs_to :contato
    validates :telefone, numericality: { only_integer: true }
end
