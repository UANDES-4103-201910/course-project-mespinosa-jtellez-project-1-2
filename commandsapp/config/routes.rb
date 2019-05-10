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
  #get '/posts/:id/comments(.format)', to: 'posts#comments', as: "post_comments"
  #get '/posts/:id/photos(.format)', to: 'posts#photos', as: "post_photos"
  #get '/posts/:id/files(.format)', to: 'posts#files', as: "post_files"
  get '/rant/:id/comments(.format)', to: 'application#comments', as: "rant_comments"
  get '/rant/:id/photos(.format)', to: 'application#photos', as: "rant_photos"
  get '/rant/:id/files(.format)', to: 'application#files', as: "rant_files"
  get '/rant/:id', to: 'application#show', as: "rant"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
