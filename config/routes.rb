Rails.application.routes.draw do
  devise_for :users
  resources :users, controllers: { sessions: 'users/sessions' }
  # get 'main/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post "/sign_out", to: "user#signout"
  root "main#home"
end
