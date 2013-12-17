class WelcomeController < ApplicationController
  skip_before_filter :restrict_non_visible_user

  def index
    if logged_in?
      @title = "People Using Date Edge"
      @users = User.visible.in_my_age_group(current_user).without(current_user).order('created_at desc')

      @crushers         = current_user.crushers
      @crushes          = current_user.crushes
      @bookmarked_users = current_user.bookmarked_users
      
      @slug     = "people"
      return render("/users/index")
    end

    @slug  = "welcome"
    @users = User.visible.order('created_at desc').limit(12)
  end
end
