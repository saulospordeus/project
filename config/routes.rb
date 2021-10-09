Rails.application.routes.draw do
  root to: 'home#index'
  resources :plans, only: [:index, :new, :create]
  devise_for :users
  resources :users, only: [:new, :create]
end
