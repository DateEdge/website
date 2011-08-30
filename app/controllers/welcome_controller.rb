class WelcomeController < ApplicationController
  skip_before_filter :restrict_non_visible_user

  def index
    @slug  = "welcome"
    @users = User.limit(12)
  end
end
