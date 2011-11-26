module ApplicationHelper
  def link_to_username(user)
    link_to user.username, person_path(user.username)
  end

  def page_title
    @title || "Date Edge : The Straightedge Dating Site"
  end

  def button_to_twitter_sign_in
    link_to "Sign in with Twitter",  "/auth/twitter", :class => "twitter_sign_in_button"
  end

  def button_to_facebook_sign_in
    '<a href="/auth/facebook" class="facebook_sign_in_button"><span>Login with <b>Facebook</b></span></a>'.html_safe
  end

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
