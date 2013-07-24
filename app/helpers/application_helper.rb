module ApplicationHelper
  def profile_incomplete?
    current_user &&
    current_user.me_gender  == "person" &&
    current_user.you_gender == "person" &&
    current_user.label_id.blank? &&
    current_user.diet_id.blank?
  end

  def birthday_select_tag(f)
    f.date_select :birthday,
                  :order         => [:month, :day, :year],
                  :start_year    => 12.years.ago.year,
                  :end_year      => 60.years.ago.year,
                  :include_blank => true
  end

  def link_to_avatar(user, avatar_size=nil)
    link_to image_tag(user.avatar(avatar_size), :class => "u-photo img", :alt => user.username),
            person_path(user.username)
  end

  def link_to_username(user)
    link_to user.username, person_path(user.username), :class => "p-name u-url"
  end

  def page_title
    @title || "Date Edge : The Straightedge Dating Site"
  end

  def button_to_sign_in_with(provider)
    if provider.to_s.downcase    == "twitter"
      link_to "Twitter",   "/auth/twitter",  :class => "twitter-sign-in-button button black"
    elsif provider.to_s.downcase == "facebook"
      link_to "Facebook",  "/auth/facebook", :class => "facebook-sign-in-button button black"
    end
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
