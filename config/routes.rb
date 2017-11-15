Rails.application.routes.draw do
  root 'dashboard#index'
  resources :player
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :tournament
  resources :match
end
