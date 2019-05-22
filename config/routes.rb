Rails.application.routes.draw do
  root 'welcome#index'

  resources :items, only: [:index, :show]

  resources :merchants, only: [:index]

  get '/cart', to: 'carts#index', as: :cart

  get '/login', to: 'sessions#new', as: :login

  get '/profile', to: 'users#show', as: :profile

  get '/register', to: 'users#new', as: :register

end
