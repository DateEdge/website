Dxe::Application.routes.draw do
  get "welcome/index"
  root :to => "welcome#index"

  resources :users, :only => [:show, :edit]

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/:provider/callback" => "sessions#create"
end
