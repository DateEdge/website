module UsersHelper

  def labels_list(user, type)
    unless user.send("desired_#{type}s").blank?
      user.send("desired_#{type}s").map{ |dd|
        "<b>#{ link_to dd.name.downcase, search_path(search: [type, dd.name]) }</b>"
      }.join("<span style='color:#999'>/</span>").html_safe
    end
  end

end
