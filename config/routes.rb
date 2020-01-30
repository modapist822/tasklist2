Rails.application.routes.draw do
  get 'session/new'
  get 'session/create'
  get 'session/destroy'
  get 'users/index'
    root to: 'tasks#index'
    
    get 'login', to: 'session#new'
    post 'login', to: 'session#create'
    delete 'logout', to: 'session#destroy'
    
    
    resources :tasks
    get 'signup', to: 'users#new'
    resources :users, only: [:index, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
