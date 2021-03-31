Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
    
  resources :tasks
    
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users, only: [:index, :create]
end
