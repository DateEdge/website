Dxe::Application.routes.draw do
  
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

  resources :photos,                       except: [:index, :show]
  resources :users,                        only:   [:destroy]
  
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
  get   "/page/:page",            to: "welcome#index"
  get   "/people/(page/:page)",   to: "users#index",  as: :people
  get   "/@:username",            to: "users#show",   as: :person, username: /[^\/]+/

  
  # TODO implement these routes
  post   "/@:username/crush",     to: "crushes#create",       as: :crush,             username: /[^\/]+/
  delete "/@:username/uncrush",   to: "crushes#destroy",      as: :uncrush,           username: /[^\/]+/
  post   "/@:username/block",     to: "blocks#create",        as: :action_block,      username: /[^\/]+/
  delete "/@:username/unblock",   to: "blocks#destroy",       as: :action_unblock,    username: /[^\/]+/
  post   "/@:username/bookmark",  to: "bookmarks#create",     as: :action_bookmark,   username: /[^\/]+/
  delete   "/@:username/unbookmark", to: "bookmarks#destroy", as: :action_unbookmark, username: /[^\/]+/
  
  # get   "/@:username/message",    to: "messages#new",      as: :action_message,    username: /[^\/]+/
  
  get "/:username", to: redirect { |params, request| "/@#{params[:username]}"}
end
