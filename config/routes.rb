Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  put '/profile/edit', to: 'users#update'
  get '/profile/orders', to: 'orders#index'
  delete '/profile/orders/:id', to: 'orders#destroy'  #should destroy be here or within resources :orders?

  get '/dashboard', to: 'users#show'
  get '/dashboard/items', to: 'items#index'
  get '/dashboard/items/new', to: 'items#new'

  resources :orders, only: [:index, :show] #should destroy be here or within profile?

  resources :carts, only: [:create] #revisit after cart class
  get '/cart', to: 'carts#index'

  resources :users, only: [:index, :show] #move to admin?

  resources :items, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  get '/merchants', to: 'users#index'
  get '/merchants/:id', to: 'users#show'

  namespace :admin do
    resources :users, only: [:index, :update, :destroy] #add edit here?
    resources :orders, only: [:update, :edit]
  end
end
