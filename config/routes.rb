Rails.application.routes.draw do
  namespace :api do
  resources :markets, only: [:index]
  
  get 'markets/index'
  end
  
end
