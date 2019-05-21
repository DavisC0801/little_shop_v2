Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index]

  resources :merchants, only: [:index]

  resources :carts, only: [:index]

  get '/login', to: 'sessions#new', as: :login

  resources :users, only: [:new, :show]
end
