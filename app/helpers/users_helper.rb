module UsersHelper

  def show_social_heading?
    ! social_sites.map{ |site, url| @user.send("#{site.downcase.gsub(/ /, "")}_username") }.join.blank?
  end

  def labels_list(user, type)
    unless user.send("desired_#{type}s").blank?
      user.send("desired_#{type}s").map{ |dd|
        "<b>#{ link_to dd.name.downcase, search_path(search: [type, dd.name]) }</b>"
      }.join("<span style='color:#999'>/</span>").html_safe
    end
  end

  def social_sites
    {
      "Twitter"        => "https://twitter.com/@@@",
      "Facebook"       => "https://facebook.com/@@@",
      "Instagram"      => "http://instagram.com/@@@",
      "This Is My Jam" => "http://thisismyjam.com/@@@",
      "Tumblr"         => "http://@@@.tumblr.com",
      "Last FM"        => "http://last.fm/user/@@@",
      "Spotify"        => "https://open.spotify.com/user/@@@",
      "Tumblr"         => "http://@@@.tumblr.com",
      "Vine"           => "https://vine.co/@@@",
      "Kik"            => "@@@",
      "Snapchat"       => "@@@"
    }
  end

end
