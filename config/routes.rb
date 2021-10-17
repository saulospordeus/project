Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :professionals, controllers: {registrations: "registrations"} 
  resources :professionals, only:[:index] do
    resources :professional_feedbacks, only: [:new, :create], as: 'feedbacks'
  end
  resources :profiles, only: [:new, :create, :show, :edit, :update]
  resources :plans, only: [:index, :new, :create, :destroy] do
    resources :offers, only: [:new, :create, :show, :index, :destroy]
    post 'offer/:id/accept', to: 'offers#accept', as: "offer_accept"
    post 'offer/:id/refuse', to: 'offers#refuse', as: "offer_refuse"
  end
  post 'plan/:id/close', to: 'plans#close', as: "close_plan"
  post 'plan/:id/open', to: 'plans#open', as: "open_plan"
    devise_for :users
  resources :users, only: [:new, :create]
end
