class WelcomeController < ApplicationController
  skip_before_filter :restrict_non_visible_user

  def index
    if logged_in?
      @slug  = "people"
      @users = User.visible
      return render("/users/index")
    end

    @slug  = "welcome"
    @users = User.visible.limit(12)
  end
end
