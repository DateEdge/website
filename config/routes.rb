Dxe::Application.routes.draw do
  root :to => "welcome#index"

  resources :users,   only: [:destroy]
  resources :photos,  :except => [:index, :show]
  resources :crushes, :only   => [:create, :destroy]

  resources :conversations, :only => [:index, :show]
  resources :messages,      :only => [:create, :new]

  get "/signout"                 => "sessions#destroy", :as => :signout
  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure"            => "sessions#failure"

  get "/start",      to: "users#new",    :as => :start
  post "/oops",       to: 'users#create', :as => :user_create
  get "/settings",   to: "users#edit",   :as => :settings
  patch "/settings",   to: "users#update", :as => :update_settings
  get "/people",     to: "users#index",  :as => :people
  get "/@:username", to: "users#show", username: /[^\/]+/ , :as => :person
end
