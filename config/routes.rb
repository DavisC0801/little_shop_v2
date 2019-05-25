Rails.application.routes.draw do
  root 'welcome#index'

  resources :items, only: [:index, :show]

  resources :merchants, only: [:index]

  get '/cart', to: 'carts#index', as: :cart

  get '/login', to: 'sessions#new', as: :login

  get '/profile', to: 'users#show', as: :profile

  get '/register', to: 'users#new', as: :register

  resources :users, only: [:create]

  get '/profile/edit', to: 'users#edit', as: :profile_edit

  patch '/profile/edit', to: 'users#update'

  scope '/user', as: 'profile' do
    resources :orders
  end

  # get '/profile/orders', to: '', as: :profile_orders
end
