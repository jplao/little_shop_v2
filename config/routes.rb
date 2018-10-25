Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/profile/:id', to: 'users#show'
  put '/profile/:id', to: 'users#update'
  get '/profile/:id/edit/', to: 'users#edit'
  get '/profile/orders', to: 'orders#index'
  delete '/profile/orders/:id', to: 'orders#destroy'  #should destroy be here or within resources :orders?

  get '/dashboard', to: 'users#show'
  get '/dashboard/items', to: 'items#index'
  get '/dashboard/items/new', to: 'items#new'

  resources :orders, only: [:index, :show] #should destroy be here or within profile?

  resources :carts, only: [:create] #revisit after cart class

  resources :users, only: [:index, :show] #move to admin?

  resources :items, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  namespace :admin do
    resources :users, only: [:update, :destroy] #add edit here?
    resources :orders, only: [:update, :edit]
  end
end
