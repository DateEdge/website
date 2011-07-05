Dxe::Application.routes.draw do

  get "conversations/index"

  get "conversations/show"

  get "messages/new"

  get "messages/create"

  get "welcome/index"
  root :to => "welcome#index"

  resources :users, :only => [:update]
  resources :photos

  resources :conversations, :only => [:index, :show]
  resources :messages,      :only => [:create, :new]

  post "/crush" => "crushes#create", :as => :crush

  match "/signout"                 => "sessions#destroy", :as => :signout
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure"            => redirect("/")

  match "/settings"  => "users#edit",   :as => :settings
  match "/people"    => "users#index",  :as => :people
  match "/:username" => "users#show",   :as => :person
end
