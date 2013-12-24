Dxe::Application.routes.draw do
  
  get "users/edit"
  get "users/index"
  constraints(subdomain: "www") do
    get '(*any)' => redirect { |params, request|
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s
    }
  end
  
  namespace :admin do
    get "/" => "dashboard#index", as: :dashboard
    resources :users, only: [:edit, :index, :update, :destroy]
  end
  
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

  get   "/oops",                  to: redirect("/start")
  patch "/oops",                  to: 'users#create', as: :user_create
  get   "/start",                 to: "users#new",    as: :start
  get   "/settings",              to: "users#edit",   as: :settings
  patch "/settings",              to: "users#update", as: :update_settings
  get   "/people",                to: "users#index",  as: :people
  get   "/@:username",            to: "users#show",   as: :person, username: /[^\/]+/
end
