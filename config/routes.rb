Rails.application.routes.draw do  
  resources :historicos, only: [:index] 
  resources :assunto_atendimentos
  root 'restrito/tela_agenda/atividades#index'
  resources :estatisticas, only: [:index] 
  resources :ferramentas_atendimento, only: [:index] 
  devise_for :admins
  resources :documentos, only: [:delete,:destroy,:update]
  resources :processos, only: [:delete,:destroy,:update,:index]
  resources :pessoas, only: [:delete,:destroy,:update]
  resources :advogados, only: [:delete,:destroy,:update]
  resources :telefones, only: [:delete,:destroy,:update]
  resources :contatos 
  resources :filiados, only: [:index, :edit,:delete,:destroy,:new,:show,:create,:update]
  namespace :restrito do
    namespace :tela_agenda do
      resources :atividades 
    end
  end
  resources :cadastro_atendimentos do 
    delete :delete_docs_attachment  
  end
  namespace :restrito do
    get 'ferramentas/index'
  end 
  namespace :restrito do
    get 'tela_consulta/index'
  end
  namespace :restrito do
    get 'tela_cadastro/index'
  end  
  namespace :restrito do
    get 'tela_agenda/index'
  end  
  namespace :restrito do
    get 'welcome/index' 
    get 'welcome/info' 
    get 'welcome/tutoriais' 
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
end
