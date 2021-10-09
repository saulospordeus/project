Rails.application.routes.draw do
  root to: 'home#index'
  resources :plans, only: [:index]
  devise_for :users
  resources :users, only: [:new, :create]
end
