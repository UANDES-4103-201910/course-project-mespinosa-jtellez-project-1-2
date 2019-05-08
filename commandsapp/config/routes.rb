Rails.application.routes.draw do
  resources :dumpsters
  resources :comments
  resources :flags
  resources :posts
  resources :blacklists
  #get '/profiles/:id/:String(.:format)', to: 'profiles#show'
  resources :profiles
  resources :administrators
  resources :users
  resources :geofences
  get '/', to: 'application#index'
  get '/profiles/:id/activity(.:format)', to: 'profiles#activity', as: "activity"
  get '/profiles/:id/rants(.:format)', to: 'profiles#rants', as: "rants"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
