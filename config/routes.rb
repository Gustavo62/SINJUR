Rails.application.routes.draw do
  resources :processos
  get 'arquivos/index'
  resources :pessoas
  resources :advogados
  resources :telefones
  resources :contatos
  namespace :restrito do
    namespace :tela_agenda do
      resources :atividades
    end
  end
  get 'arquivos/index'
  post 'arquivos/upload_arquivo'
  post 'arquivos/download_arquivo'
  root 'restrito/welcome#index'
  namespace :restrito do
    get 'ferramentas/index'
  end
  namespace :restrito do
    get 'tela_consulta/index'
  end
  namespace :restrito do
    get 'tela_cadastro/index'
  end
  resources :filiados
  namespace :restrito do
    get 'tela_agenda/index'
  end
  resources :cadastro_atendimentos
  resources :tabeliaos
  namespace :restrito do
    get 'welcome/index'
  end
  namespace :site do
    get 'welcome/index'
  end
  namespace :advogados_backoffice do
    get 'welcome/Cadastrar_Pessoas'
  end
  namespace :advogados_backoffice do
    get 'welcome/Cadastrar_Atendimento'
  end
  namespace :advogados_backoffice do
    get 'welcome/agenda'
  end
  namespace :site do
    get 'site/welcome/index'
  end
  devise_for :admins  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
