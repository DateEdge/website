Dxe::Application.routes.draw do

  # No WWW
  constraints(subdomain: "www") do
    get '(*any)' => redirect { |params, request|
      URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s
    }
  end

  # Admin
  namespace :admin do
    get    "/" => "dashboard#index",                as: :dashboard
    get    "/@:username/edit", to: "users#edit",    as: :edit_user,   username: /[^\/]+/
    patch  "/@:username",      to: "users#update",  as: :update_user, username: /[^\/]+/
    delete "/@:username",      to: "users#destroy", as: :user,        username: /[^\/]+/
  end

  # Static-y pages
  root to: "welcome#index"
  get "/terms",                   to: "about#terms",      as: :terms
  get "/privacy-policy",          to: "about#privacy",    as: :privacy
  get "/about",                   to: "about#us",         as: :about
  get "/goodbye",                 to: "about#goodbye",    as: :goodbye
  get "/page/:page",              to: "welcome#index"

  # Auth
  get "/signout",                 to: "sessions#destroy", as: :signout
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure",            to: "sessions#failure"

  # People objects
  resources :photos,              except: [:index, :show]
  resources :conversations,       only:   [:index]

  # People pages
  get    "/oops",                  to: redirect("/start")
  patch  "/oops",                  to: 'users#create',  as: :user_create
  get    "/start",                 to: "users#new",     as: :start
  get    "/settings",              to: "users#edit",    as: :settings
  patch  "/settings",              to: "users#update",  as: :update_settings
  get    "/people/(page/:page)",   to: "users#index",   as: :people
  get    "/@:username",            to: "users#show",    as: :person, username: /[^\/]+/
  get    "/@:username",            to: "users#show",    as: :user,   username: /[^\/]+/
  delete "/@:username",            to: "users#destroy", username: /[^\/]+/

  # Action paths
  post   "/@:username/crush(.:format)",      to: "crushes#create",        as: :crush,               username: /[^\/]+/
  delete "/@:username/uncrush(.:format)",    to: "crushes#destroy",       as: :uncrush,             username: /[^\/]+/
  post   "/@:username/block(.:format)",      to: "blocks#create",         as: :action_block,        username: /[^\/]+/
  delete "/@:username/unblock(.:format)",    to: "blocks#destroy",        as: :action_unblock,      username: /[^\/]+/
  post   "/@:username/bookmark(.:format)",   to: "bookmarks#create",      as: :action_bookmark,     username: /[^\/]+/
  delete "/@:username/unbookmark(.:format)", to: "bookmarks#destroy",     as: :action_unbookmark,   username: /[^\/]+/
  get    "/@:username/message",              to: "messages#new",          as: :new_message,         username: /[^\/]+/
  post   "/@:username/message(.:format)",    to: "messages#create",       as: :messages,            username: /[^\/]+/
  get    "/@:username/conversation",         to: "conversations#show",    as: :conversation,        username: /[^\/]+/
  delete "/@:username/conversation",         to: "conversations#destroy", as: :delete_conversation, username: /[^\/]+/

  # filters
  get "/diets",                     to: "searches#index",  as: :diets            , column: "diets"
  get "/genders",                   to: "searches#index",  as: :genders          , column: "genders"
  get "/straightedgeness",          to: "searches#index",  as: :straightedgeness , column: "straightedgeness"
  get "/straightedgeness",          to: "searches#index",  as: :label            , column: "straightedgeness"
  get "/search/*search/page/:page", to: "searches#show"
  get "/search/*search",            to: "searches#show",   as: :search

  # Last ditch effort to catch mistyped @username paths
  get "/:username", to: redirect { |params, request| "/@#{params[:username]}"}

end
