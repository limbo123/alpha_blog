Rails.application.routes.draw do
  root "application#index"
  resources :articles
  resources :users, except: [:new]
  get "registrate", to: "users#new"
  get "login", to: "sessions#new"
  post "authenticate", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :categories, except: [:destroy]
end
