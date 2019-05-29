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

  patch '/profile/orders/:id/', to: "orders#cancel"

  get '/dashboard', to: 'merchants#show'

  scope :dashboard, as: :dashboard, module: :merchants do
    resources :items, only: [:index, :new, :edit, :show, :destroy]
    post "/items/deactivate", to: "/merchants/items#deactivate"
    post "/items/activate", to: "/merchants/items#activate"
    resources :orders, only: :show
  end

  resources :items, only: [:index, :show]

  resources :merchants, only: [:index]

  resources :users, only: [:create]

  resources :carts, only: [:create]

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end

  get '/carts', to: 'carts#show', as: 'cart'
  put '/carts', to: 'carts#update'
  delete '/carts', to: 'carts#destroy'
end
