Rails.application.routes.draw do
  devise_for :supervisors, controllers: {
    sessions: 'supervisors/sessions'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users
  resources :admins
  resources :supervisors, only: [:index]
  # get 'main/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post "/sign_out", to: "user#signout"
  as :admin do
    get 'admins', :to => 'admins#index', :as => :admins_root # Rails 3
  end
  as :supervisor do
    get 'supervisors', :to => 'supervisors#index', :as => :supervisors_root # Rails 3
  end
  get '/supervisors/listar_usuarios', :to => 'supervisors#listar_usuarios'
  root "users#index"
end
