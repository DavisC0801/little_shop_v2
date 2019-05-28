Rails.application.routes.draw do

  root to: 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit', as: :profile_edit
  patch '/profile/edit', to: 'users#update'

  scope :profile, as: :profile do
    resources :orders, only: [:index, :show]
  end

  get '/dashboard', to: 'merchants#show'

  scope :dashboard, as: :dashboard do
    resources :items, only: [:index, :new, :edit, :show]
    resources :orders, only: :show
  end

  resources :items, only: [:index, :show]

  resources :merchants, only: [:index]

  resources :users, only: [:create]

  resources :carts, only: [:create]

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :users, only: [:index, :edit, :show]
    resources :users, only: :index do
      resources :orders, only: [:index, :show]
    end
    resources :merchants, only: :show do
      resources :items, only: [:index, :new, :edit]
      get '/orders/:id', to: 'orders#merchant_show', as: :show
    end
  end

  get '/carts', to: 'carts#show', as: 'cart'
  put '/carts', to: 'carts#update'
  delete '/carts', to: 'carts#destroy'
end
