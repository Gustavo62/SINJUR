class FerramentasAtendimentoController < ApplicationController
    layout 'restrito'
    def index
        @local = 'Atendimento > Ferramentas.'
        @assunto_atendimentos = AssuntoAtendimento.all
    end
end
