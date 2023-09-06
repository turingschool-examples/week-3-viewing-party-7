Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  resources :movies do 
    resources :viewing_parties, only: [:new, :create]
  end
  get '/no_show', to: 'movies#no_show'
  # resources :users, only: :show, path: '/dashboard'
  get '/dashboard', to: 'users#show'

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  get "/logout", to: "users#logout"
end
