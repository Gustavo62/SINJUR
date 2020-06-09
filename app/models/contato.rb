class Contato < ApplicationRecord 
    has_many :telefones
    accepts_nested_attributes_for :telefones, reject_if: :all_blank,allow_destroy: true 
end
