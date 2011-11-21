Dxe::Application.routes.draw do

  root :to => "welcome#index"

  resources :users, :only => [:update, :destroy]
  resources :photos
  resources :crushes, :only => [:create, :destroy]

  resources :conversations, :only => [:index, :show]
  resources :messages,      :only => [:create, :new]

  match "/signout"                 => "sessions#destroy", :as => :signout
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure"            => "sessions#failure"

  match "/start"     => "users#new",    :as => :start
  match "/oops"      => 'users#create', :as => :user_create
  match "/settings"  => "users#edit",   :as => :settings
  match "/people"    => "users#index",  :as => :people
  match "/:username" => "users#show",   :as => :person
end
