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
  resources :reportes, only: [:show]
	resources :locations, only: :create
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


  as :admin do
    get '/admins', :to => 'admins#estadisticas', :as => :admins_root # Rails 3
  end

  as :user do
    # generate route that recives the id of a auto
    get 'users', :to => 'users#index', :as => :users_root # Rails 3
  end

  # get "admins/edit/:id", to: "admins/registrations#edit"
  # put "admins/edit/:id", to: "admins/registrations#update"

  get '/users/vehiculo/:id', :to => 'users#vehiculo', :as => :vehiculo
  get '/admins/listar_usuarios', :to => 'admins#listar_usuarios'
  get '/admins/listar_no_validados', :to => 'admins#listar_no_validados'
  get '/admins/listar_supervisores', :to => 'admins#listar_supervisores'
  get '/autos', :to => 'autos#listadoDeAutos'

  get '/admins/showUser/:id', :to => 'admins#showUser', as: 'showUser'

  root "main#home"

  get '/wallets/:user_id', :to => 'wallets#mostrar_wallet'
  put '/wallets/cargar_saldo/:user_id', :to => 'wallets#cargar_saldo'

  get '/precios', :to => 'precios#index'
  post '/precios/editarPrecio', :to => 'precios#editarPrecio'

  put '/cards/create/', :to => 'cards#create'
  get '/users/vista_mapa', :to => 'users#vista_mapa'
  get '/cards/create', :to => 'cards#new', :as => 'new_card'

  put '/admins/updateUserStatus/:user_id', :to => 'admins#updateUserStatus'

  get '/users/vista_alquiler', :to => 'users#vista_alquiler'

  put '/users/finalizar_alquiler', :to => 'users#finalizar_alquiler'

  post '/users/alquilar/:auto_id', :to => 'users#alquilar'

  get '/users/certificado', :to => 'users#certificado'

  get '/abrir_cerrar/:id', :to => 'users#abrir_cerrar'

  get 'alquiler/resumen', :to => 'users#resumen', :as => 'resumen'

  get '/admins/listado_reportes', :to => 'reportes#index'

  get '/admins/estadisticas', :to => 'admins#estadisticas'

  get '/admins/estadisticas/alquileres', :to => 'admins#estadisticas_alquileres'

  get '/admins/estadisticas/ganancias', :to => 'admins#estadisticas_ganancias'

  get '/admins/estadisticas/reportes', :to => 'admins#estadisticas_reportes'

  get '/admins/estadisticas/en_curso', :to => 'admins#estadisticas_en_curso'

  get '/users/reportes/new', :to => 'reportes#new', :as => 'new_reporte'

  post '/users/reportes/create', :to => 'reportes#create', :as => 'create_reporte'

  put '/users/prolongar_alquiler', :to => 'users#prolongar_alquiler'

  put '/atender_reporte/:id', :to => 'reportes#atender_reporte'

  put '/finalizar_reporte/:id', :to => 'reportes#finalizar_reporte'

  get '/admins/historial_de_uso/:id', :to => 'admins#historial_de_uso'

  get '/alquiler/show/:id', :to => 'admins#show_alquiler'

  get '/', :to => 'main#home'

  #match "*path" => redirect("/"), via: [:get, :post]   #DEJAR SIEMPRE AL FINAL

end
