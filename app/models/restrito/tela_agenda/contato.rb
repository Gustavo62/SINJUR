class Restrito::TelaAgenda::Contato < ApplicationRecord
    has_many :telefones
    accepts_nested_attributes_for :telefones
end
