Rails.application.routes.draw do
  devise_for :supervisors
  devise_for :admins
  devise_for :users
  resources :users, controllers: { sessions: 'users/sessions' }
  resources :admins, controllers: { sessions: 'admins/sessions' }
  resources :supervisors, controllers: { sessions: 'supervisors/sessions' }
  # get 'main/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post "/sign_out", to: "user#signout"
  root "users#index"
end
