Dxe::Application.routes.draw do
  root to: "welcome#index"

  resources :users,     only:   [:destroy]
  resources :photos,    except: [:index, :show]
  resources :crushes,   only:   [:create, :destroy]
  resources :bookmarks, only:   [:create, :destroy]

  resources :conversations, only: [:index, :show]
  resources :messages,      only: [:create, :new]

  get "/terms",                   to: "about#terms",      as: :terms
  
  get "/signout",                 to: "sessions#destroy", as: :signout
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure",            to: "sessions#failure"

  get   "/start",                 to: "users#new",    as: :start
  post  "/oops",                  to: 'users#create', as: :user_create
  get   "/settings",              to: "users#edit",   as: :settings
  patch "/settings",              to: "users#update", as: :update_settings
  get   "/people",                to: "users#index",  as: :people
  get   "/@:username",            to: "users#show",   as: :person, username: /[^\/]+/ 
end
