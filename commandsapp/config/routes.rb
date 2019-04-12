Rails.application.routes.draw do
  resources :comments
  resources :flags
  resources :posts
  resources :blacklists
  resources :profiles
  resources :administrators
  resources :users
  resources :geofences
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
