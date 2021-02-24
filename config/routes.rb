Rails.application.routes.draw do
  namespace :api do
  resources :markets, only: [:index]
  resources :currencies, only: [:index]
  end
end
