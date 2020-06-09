class Restrito::TelaAgenda::Atividade < ApplicationRecord 
    def start_time 
        self.agendamento
    end
end
