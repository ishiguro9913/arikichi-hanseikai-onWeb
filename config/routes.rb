Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  root 'users#new'
  resources :users
  resources :posts
  get '/result', to: 'results#new', as: 'result'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/guest_login', to: 'user_sessions#guest_login'

  # twitter認証
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
