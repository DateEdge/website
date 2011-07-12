class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :restrict_non_visible_user
  helper_method :current_user
  helper_method :unread_count
  helper_method :redirect_age_inappropriate

  private
  
  def redirect_if_age_inappropriate(user)
    redirect_to people_path if user.nil? || user.age_inappropiate?(current_user)
  end

  def restrict_non_visible_user
    if current_user && !current_user.visible?
      redirect_to start_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def unread_count
    Conversation.unread_messages(current_user)
  end
end
