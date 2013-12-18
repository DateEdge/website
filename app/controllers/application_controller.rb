class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :restrict_non_visible_user
  helper_method :current_user
  helper_method :unread_count
  helper_method :redirect_age_inappropriate
  helper_method :logged_in?
  helper_method :im
  helper_method :getting_started?

  private

  def back_or(path=nil)
    request.referer || path ||= root_path
  end
  
  def getting_started?
    params[:getting] == "started"
  end

  def logged_in?
    current_user
  end
  alias :im :logged_in?

  def redirect_if_age_inappropriate(user)
    redirect_to people_path if user.nil? || user.age_inappropiate?(current_user)
  end

  def restrict_non_visible_user
    if current_user && !current_user.visible?
      redirect_to start_path
    end
  end
  
  def require_login
    unless current_user
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def unread_count
    messages = current_user.inbound_messages.unread.map(&:conversation_id).uniq.count
    messages.zero? ? nil : messages
  end
end
