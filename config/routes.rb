Rails.application.routes.draw do
  root "application#index"
  resources :articles
  resources :users
  get "registrate", to: "users#new"
  get "login", to: "sessions#new"
  post "authenticate", to: "sessions#create"
end
