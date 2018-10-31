Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'

  get '/profile', to: 'users#show'
  get '/profile/edit/', to: 'users#edit'
  get '/profile/orders', to: 'orders#index'

  namespace :dashboard do
    resources :items, only: [:index, :new, :create]
    resources :orders, only: [:index]
  end

  get '/dashboard', to: 'dashboard#show'

  resources :orders, only: [:index, :show, :destroy, :create]

  post '/cart', to: 'carts#create'
  get '/cart', to: 'carts#index'
  put '/cart', to: 'carts#update'
  delete '/cart', to: 'carts#destroy'

  resources :users, only: [:show, :update, :edit, :index] do
    resources :orders, only: [:index]
  end

  resources :items, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  get '/merchants', to: 'users#index'
  resources :merchants, only: [:show] do
    resources :orders, only: [:index]
  end
  # get '/merchants/:id', to: 'users#show'

  namespace :admin do
    resources :users, only: [:update, :destroy]
    resources :orders, only: [:update, :edit]
  end

  resources :order_items, only: [:update]
end
