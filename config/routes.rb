Rails.application.routes.draw do
  resources :ratings
  resources :tabs
  resources :chords
  delete '/logout', to: 'sessions#destroy'
  get 'sessions/new'

  root to: "users#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  

  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
