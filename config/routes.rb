Rails.application.routes.draw do

  devise_scope :admin do
    get 'admins/editSupervisor/:id', to: 'admins/registrations#editSupervisor', as: 'editSupervisor'
  end

  devise_scope :admin do
    put 'admins/updateSupervisor/:id', to: 'admins/registrations#updateSupervisor', as: 'updateSupervisor'
  end

  devise_scope :admin do
    delete 'admins/deleteSupervisor/:id', to: 'admins/registrations#deleteSupervisor', as: 'deleteSupervisor'
  end

  devise_scope :user do
    put 'users/edit', to: 'users/registrations#updateUser', as: 'updateUser'
  end

  put "/autos/cambiarEstado/:auto_id", to: "autos#cambiarEstado", as: "cambiarEstado"

  resources :autos, only: [:new, :create, :edit, :update]
  resources :precios
  # devise_for :supervisors, controllers: {
  #   sessions: 'supervisors/sessions'
  # }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  resources :users, only: [:index]
  resources :admins, only: [:index]


  as :admin do
    get 'admins', :to => 'admins#index', :as => :admins_root # Rails 3
  end

  as :user do
    get 'users', :to => 'users#index', :as => :users_root # Rails 3
  end

  # get "admins/edit/:id", to: "admins/registrations#edit"
  # put "admins/edit/:id", to: "admins/registrations#update"


  get '/admins/listar_usuarios', :to => 'admins#listar_usuarios'
  get '/admins/listar_supervisores', :to => 'admins#listar_supervisores'
  get '/autos', :to => 'autos#listadoDeAutos'

  get '/admins/showUser/:id', :to => 'admins#showUser', as: 'showUser'

  root "main#home"

  get '/wallets/:user_id', :to => 'wallets#mostrar_wallet'
  put '/wallets/cargar_saldo/:user_id', :to => 'wallets#cargar_saldo'

  get '/precios', :to => 'precios#index'
  post '/precios/editarPrecio', :to => 'precios#editarPrecio'













































































































































  #match "*path" => redirect("/"), via: [:get, :post]   #DEJAR SIEMPRE AL FINAL

end
