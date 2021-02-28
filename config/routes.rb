Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  namespace :api do
  resources :markets, only: [:index]
  resources :currencies, only: [:index]
  resources :news, only: [:index]
  resources :buy_signals, only: [:index]
  resources :subscriptions, only: [:index, :create]
  end
end
