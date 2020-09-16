namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando Bd..."){%x(rails db:drop)}
      show_spinner(" Criando Bd..."){%x(rails db:create)}
      show_spinner("Migrando Bd..."){%x(rails db:migrate)}
    end
    show_spinner("Cadastrando advogado padrão..."){%x(rails dev:add_default_admin)}  
  end
  desc "Adiciona o Advogado padrão."
  task add_default_admin: :environment do
    Admin.create!(
      email: 'mirlenyalves35@gmail.com',
      password: 123456,
      password_confirmation: 123456
    )
    Admin.create!(
      email: 'julianapfalcao@gmail.com',
      password: 123456,
      password_confirmation: 123456
    )
    Admin.create!(
      email: 'contato@sinoredice.org.br',
      password: 123456,
      password_confirmation: 123456
    )
  end
  def show_spinner(msg_start, msg_end = "Concluido!")
    spinner = TTY::Spinner.new("[]:Spinner #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end

