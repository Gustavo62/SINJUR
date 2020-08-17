class EstatisticasController < ApplicationController
    layout 'restrito'
  def index
    @qtd_de_atend = CadastroAtendimento.all.size
    @local = 'Painel de controle'
    @qtd_procs = Processo.all.size
    @procs = Processo.all
    @atends = CadastroAtendimento.all
    efetividade_procs
    efetividade_atvs
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
  def efetividade_atvs
    @status_a = 0
    @status_b = 0
    @result = 0 
    @nivel_alto = 0
    @nivel_medio = 0
    @nivel_baixo = 0
    Restrito::TelaAgenda::Atividade.all.each do |atividade|
      if atividade.status == "Aberto"
        @status_a += 1
      end
      if atividade.status == "Concluido"
        @status_b += 1
      end 
      @porcentagem_atividades_aberto = (@status_a.to_f)/(@status_a+@status_b)*100
      @porcentagem_atividades_concluido = (@status_b.to_f/(@status_a+@status_b))*100  

      if atividade.nivel == "Alto"
        @nivel_alto += 1
      end
      if atividade.nivel == "Médio"
        @nivel_medio += 1
      end
      if atividade.nivel == "Baixo"
        @nivel_baixo += 1
      end
    end 
    @result = @status_a + @status_b
  end 
  
end