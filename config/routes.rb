Dxe::Application.routes.draw do

  constraints(subdomain: "www") do
    get '(*any)' => redirect { |params, request|
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s
    }
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

  # TODO implement these routes
  # get   "/@:username/crush",      to: "crushes#new",       as: :action_crush,      username: /[^\/]+/
  # get   "/@:username/uncrush",    to: "crushes#destroy",   as: :action_uncrush,    username: /[^\/]+/
  # get   "/@:username/bookmark",   to: "bookmarks#new",     as: :action_bookmark,   username: /[^\/]+/
  # get   "/@:username/unbookmark", to: "bookmarks#destroy", as: :action_unbookmark, username: /[^\/]+/
  # get   "/@:username/message",    to: "messages#new",      as: :action_message,    username: /[^\/]+/
  # get   "/@:username/block",      to: "blocks#new",        as: :action_block,      username: /[^\/]+/

end
