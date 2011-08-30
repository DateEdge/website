module ApplicationHelper
  def logged_in?
    current_user
  end
  alias :im :logged_in?

  def mine?
    current_user && current_user == @user
  end

  def not_mine?
    current_user && current_user != @user
  end

  def google_map_url(user)
    url  = "http://maps.google.com/maps?q="

    pieces = []
    pieces << user.city         if user.city
    pieces << user.state        if user.state
    pieces << user.country.name if user.country

    url << u(pieces.join(", "))
    url
  end
end
