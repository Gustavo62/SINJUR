class Documento < ApplicationRecord
    has_one_attached :documento
    belongs_to :cadastro_atendimento
end
