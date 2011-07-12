class WelcomeController < ApplicationController
  skip_before_filter :restrict_non_visible_user

  def index; session[:user_id] = 3;end
end
