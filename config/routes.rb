Rails.application.routes.draw do
  root 'users#new'

  resources :users
  resources :posts

  delete 'logout', to: 'user_sessions#destroy' 

  get '/result', to: 'results#new', as: 'result'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/guest_login', to: 'user_sessions#guest_login', as: 'guest_login'
  post '/twitter_login', to: 'user_sessions#guest_login'

  # twitter認証
  get 'oauths/oauth' # いる？
  get 'oauths/callback' # いる？
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # get '/auth/:provider/callback', to: 'sessions#create'
  # get '/logout', to: 'sessions#destroy'
end
