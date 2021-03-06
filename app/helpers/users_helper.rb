module UsersHelper

  def show_section?(type)
    if type == :social
      ! social_sites.map{ |site, url| @user.send("#{site.downcase.gsub(/ /, "")}_username") }.join.blank?
    elsif type == :contact
      (@user.email? && @user.email_public?) # || @user.website?
    end
  end

  def labels_list(user, type)
    unless user.send("desired_#{type}").blank?
      user.send("desired_#{type}").map{ |dd|
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
      "Vine"           => "https://vine.co/@@@",
      "Kik"            => "@@@",
      "Snapchat"       => "@@@"
    }
  end
end
