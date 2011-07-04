Dxe::Application.routes.draw do
  get "welcome/index"
  root :to => "welcome#index"

  resources :users, :except => [:new, :create]

  match "/settings" => "users#edit", :as => :settings

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => redirect("/")
end
