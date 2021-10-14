Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :professionals, controllers: {registrations: "registrations"}
  resources :offers, only: [:new, :create]
  resources :profiles, only: [:new, :create]
  resources :plans, only: [:index, :new, :create]
  devise_for :users
  resources :users, only: [:new, :create]
end
