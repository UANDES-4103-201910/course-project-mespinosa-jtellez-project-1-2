Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  delete '/profiles/:id', to:'users#destroy_selected_user', as: "destroy_selected_user"
  resources :dumpsters
  resources :comments
  resources :flags
  resources :posts
  resources :blacklists
  #get '/profiles/:id/:String(.:format)', to: 'profiles#show'
  resources :profiles

  delete '/administrators', to: 'administrators#destroy_selected', as: "administrators_destroy_selected"
  delete '/blacklists', to: 'blacklists#destroy_selected', as: "blacklist_destroy_selected"
  delete '/dumpsters', to: 'dumpsters#destroy_selected', as: "dumpster_destroy_selected"

  post '/profiles/:id', to:'administrators#create', as: "create_admin"

  get '/upvote/:id', to: 'posts#upvote', as: "upvote"
  get '/downvote/:id', to: 'posts#downvote', as: "downvote"

  resources :administrators
  resources :users
  resources :geofences
  root to: 'application#index', as: "root"
  get '/log_in', to: 'sessions#new', as: "log_in"
  get '/log_out', to: 'sessions#destroy', as: "log_out"

  get '/profiles/:id/activity(.:format)', to: 'profiles#activity', as: "activity"
  get '/profiles/:id/rants(.:format)', to: 'profiles#rants', as: "rants"
  #get '/posts/:id/comments(.format)', to: 'posts#comments', as: "post_comments"
  #get '/posts/:id/photos(.format)', to: 'posts#photos', as: "post_photos"
  #get '/posts/:id/files(.format)', to: 'posts#files', as: "post_files"
  get '/rant/:id/comments(.format)', to: 'application#comments', as: "rant_comments"
  get '/rant/:id/photos(.format)', to: 'application#photos', as: "rant_photos"
  get '/rant/:id/files(.format)', to: 'application#files', as: "rant_files"
  get '/rant/:id', to: 'application#show', as: "rant"

  get "/register", to: 'users#new', as: "register"

  get '/rant/:id/file_selected', to: 'application#show_file', as: "file"
  get '/search', to: 'application#search', as: "search"

  get '/search/blacklist', to: 'blacklists#search', as: "blacklist_search"
  get '/search/dumpster', to: 'dumpsters#search', as: "dumpster_search"

  get '/terms_of_use', to: 'application#terms_of_use', as: "terms_of_use"
  get '/terms_of_service', to: 'application#terms_of_service', as: "terms_of_service"

  scope '/admin', admin_scope: true do
    #get '/profiles/:id/:String(.:format)', to: 'profiles#show'
    get "/admin/profiles/:id(.:format)", to: "profiles_admin#show", as: "profile_admin_show"
    resources :profiles, controller: "profiles_admin"
    get '/', to: 'application_admin#index'
    get '/profiles/:id/activity(.:format)', to: 'profiles_admin#activity', as: "activity_admin"
    get '/profiles/:id/rants(.:format)', to: 'profiles_admin#rants', as: "rants_admin"
    #get '/posts/:id/comments(.format)', to: 'posts#comments', as: "post_comments"
    #get '/posts/:id/photos(.format)', to: 'posts#photos', as: "post_photos"
    #get '/posts/:id/files(.format)', to: 'posts#files', as: "post_files"
    get '/rant/:id/comments(.format)', to: 'application_admin#comments', as: "rant_comments_admin"
    get '/rant/:id/photos(.format)', to: 'application_admin#photos', as: "rant_photos_admin"
    get '/rant/:id/files(.format)', to: 'application_admin#files', as: "rant_files_admin"
    get '/rant/:id', to: 'application_admin#show', as: "rant_admin"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
