class Restrito::TelaAgenda::Atividade < ApplicationRecord 
    def start_time 
        self.agendamento
    end 
    validates :agendamento,:resumo, presence: true 
end
