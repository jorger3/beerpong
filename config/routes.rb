Rails.application.routes.draw do
  root 'dashboard#index'
  resources :player
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post '/tournament/:id/finished/:finished' => 'tournament#finished'
  resources :tournament
  resources :match
end
