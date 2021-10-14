Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :professionals, controllers: {registrations: "registrations"}
  resources :profiles, only: [:new, :create]
  resources :plans, only: [:index, :new, :create] do
    resources :offers, only: [:new, :create, :show]
  end
  devise_for :users
  resources :users, only: [:new, :create]
end
