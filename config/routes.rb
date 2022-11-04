Rails.application.routes.draw do
  get 'autos/listadoDeAutos'
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
  resources :users
  resources :admins, only: [:index, :edit, :update]
  # resources :supervisors, only: [:index]
  # get 'main/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post "/sign_out", to: "user#signout"
  as :admin do
    get 'admins', :to => 'admins#index', :as => :admins_root # Rails 3
  end

  # as :supervisor do
  #   get 'supervisors', :to => 'supervisors#index', :as => :supervisors_root # Rails 3
  # end

  as :user do
    get 'users', :to => 'users#index', :as => :users_root # Rails 3
  end

  # get "admins/edit/:id", to: "admins/registrations#edit"
  # put "admins/edit/:id", to: "admins/registrations#update"


  get '/admins/listar_usuarios', :to => 'admins#listar_usuarios'
  get '/admins/listar_supervisores', :to => 'admins#listar_supervisores'

  root "main#home"
  match "*path" => redirect("/"), via: [:get, :post]
end
