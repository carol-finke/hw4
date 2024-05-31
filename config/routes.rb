Rails.application.routes.draw do
  root to: 'places#index'

  resources :places do
    resources :entries, only: [:index, :new, :create]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
end
