Rails.application.routes.draw do
  devise_for :users

  root "products#index"
  resources :products
  # resources :checkout, only: [:create]
  post "checkout/create", to: "checkout#create"
  resources :webhooks, only: [:create]
  get "success", to: "checkout#success"
  get "cancel", to: "checkout#cancel"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
