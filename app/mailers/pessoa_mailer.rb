class PessoaMailer < ApplicationMailer
  before_action :load_atendimento
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pessoa_mailer.avisoAtendimentoAdd.subject
  #
  def avisoAtendimentoAdd
    @greeting = "Olá" 
    @cadastro_atendimento.pessoas.each do |pessoa|
      @nome = pessoa.nome
      mail from: 'suporte@sinoredice.org.br',to: 'suporte@sinoredice.org.br',subject: "Atendimento nº #{@cadastro_atendimento.id} Sinjur no dia #{l(@cadastro_atendimento.created_at, :format => "%d de %B de %Y", :locale => 'pt-BR')}"
    end
  end

  private
 
  def load_atendimento
    @cadastro_atendimento = params[:cadastro_atendimento]
  end
end
