class WelcomeController < ApplicationController
  skip_before_filter :restrict_non_visible_user

  def index
    if logged_in?
      @title = "People Using Date Edge"
      @users = current_user.viewable_users.order('created_at desc')

      @crushers         = current_user.crushers
      @crushes          = current_user.crushes
      @bookmarked_users = current_user.bookmarked_users
      
      @slug     = "people"
      return render("/users/index")
    end

    @slug  = "welcome"
    @users = User.visible.featured.shuffle.first(12)
  end
end
