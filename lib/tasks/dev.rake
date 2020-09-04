namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando Bd..."){%x(rails db:drop)}
      show_spinner(" Criando Bd..."){%x(rails db:create)}
      show_spinner("Migrando Bd..."){%x(rails db:migrate)}
    end
    if Rails.env.production?
      show_spinner("Cadastrando advogado padrão..."){%x(rails dev:add_default_admin)}   
    end
  end
  desc "Adiciona o Advogado padrão."
  task add_default_admin: :environment do
    Admin.create!(
      email: 'advogado@teste.com',
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

