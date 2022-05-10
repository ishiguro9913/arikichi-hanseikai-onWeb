Rails.application.routes.draw do
  root 'users#new'
  resources :users
  resources :posts
  get '/result', to: 'results#new', as: 'result'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/guest_login', to: 'user_sessions#guest_login'
end
