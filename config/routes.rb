Rails.application.routes.draw do
  devise_for :professionals
  root to: 'home#index'
  resources :plans, only: [:index, :new, :create]
  devise_for :users
  resources :users, only: [:new, :create]
end
