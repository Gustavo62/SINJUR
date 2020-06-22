Rails.application.routes.draw do
  get 'estatisticas/index'
  resources :estatisticas
  devise_for :admins 
  resources :documentos
  resources :processos 
  resources :pessoas
  resources :advogados
  resources :telefones
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
  namespace :restrito do
    get 'tela_agenda/index'
  end 
  resources :tabeliaos
  namespace :restrito do
    get 'welcome/index' => 'static_pages#welcome/index'
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
