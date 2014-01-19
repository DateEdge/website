class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["STAGING_USERNAME"], password: ENV["STAGING_PASSWORD"] if Rails.env.staging?
  
  protect_from_forgery
  before_filter :restrict_non_visible_user
  helper_method :current_user
  helper_method :unread_count
  helper_method :redirect_age_inappropriate
  helper_method :logged_in?
  helper_method :im
  helper_method :getting_started?

  private
  
  def find_user_by_username
    @user = User.visible.find_by(canonical_username: params[:username].downcase)
  end

  def back_or(path=nil)
    request.referer || path ||= root_path
  end

  def getting_started?
    params[:getting] == "started" ||
    request.path     =~ /start/ ||
    request.path     =~ /oops/
  end

  def logged_in?
    current_user
  end
  alias :im :logged_in?

  def logged_in_as_admin?
    logged_in? && current_user.admin?
  end
  
  def redirect_if_age_inappropriate(user)
    redirect_to people_path if user.nil? || user.age_inappropiate?(current_user)
  end

  def restrict_non_visible_user
    if current_user && !current_user.visible?
      redirect_to start_path
    end
  end
  
  def restrict_blocked_user(user, path=nil)
    path ||= root_path
    redirect_to path, notice: "@#{user.username} is not available to message." if current_user.block_with_user?(user)
  end

  def require_login
    redirect_to root_path unless logged_in?
  end
  
  def require_admin
    redirect_to root_path unless logged_in_as_admin?
  end

  def current_user
    if session[:user_id] # This is only to temporarily allow both session and cookie method, delete this on the next deploy.
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    else
      @current_user ||= User.find_by(auth_token: cookies.signed[:auth_token]) if cookies[:auth_token]
    end
  end

  def unread_count
    messages = current_user.inbound_messages.unread.map(&:conversation_id).uniq.count
    messages.zero? ? nil : messages
  end
end
