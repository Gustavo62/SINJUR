class Filiado < ApplicationRecord
    has_one :tabeliao
    accepts_nested_attributes_for :tabeliao
end
