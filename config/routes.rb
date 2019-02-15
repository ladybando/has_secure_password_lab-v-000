Rails.application.routes.draw do
  root 'application#index'
  resources :users, only: [:new, :create]
   get '/index' => 'users#index'
   resources :sessions, only: [:new, :create]
end
