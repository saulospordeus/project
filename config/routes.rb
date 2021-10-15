Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :professionals, controllers: {registrations: "registrations"} 
  resource :professionals, only:[:index] do
    resources :professionalfeedbacks, only: [:new, :create], as: "feedback"
  end
  resources :profiles, only: [:new, :create, :show]
  resources :plans, only: [:index, :new, :create] do
    resources :offers, only: [:new, :create, :show, :index]
    post 'offer/:id/accept', to: 'offers#accept', as: "offer_accept"
    post 'offer/:id/refuse', to: 'offers#refuse', as: "offer_refuse"
  end
  devise_for :users
  resources :users, only: [:new, :create]
end
