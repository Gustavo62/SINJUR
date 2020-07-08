class EstatisticasController < ApplicationController
    layout 'restrito'
  def index
    @qtd_de_atend = CadastroAtendimento.all.size
    @local = 'Estatisticas'
    @qtd_procs = Processo.all.size
    @procs = Processo.all
    @atends = CadastroAtendimento.all
    efetividade_procs
    @atividades = Restrito::TelaAgenda::Atividade.all
  end
  def efetividade_procs
    @montante_a = 0
    @montante_b = 0
    @montante_c = 0
    @favoritos = 0
    Processo.all.each do |processos|
      if processos.status_processo == "Aberto"
       @montante_a += 1
      end
      if processos.status_processo == "Em processamento"
        @montante_b += 1
      end
      if processos.status_processo == "Concluido"
        @montante_c += 1
      end
      if processos.favorito == "1"
        @favoritos += 1
      end
      @porcentagem_status_concluido = (@montante_c.to_f)/(@montante_a+@montante_b+@montante_c)*100
      @porcentagem_status_aberto = (@montante_a.to_f/(@montante_a+@montante_b+@montante_c))*100
      @porcentagem_status_em_andamento =(@montante_b.to_f/(@montante_a+@montante_b+@montante_c))*100
      
    end 
  end
end