module UsersHelper

  def desired_diets(user)
    unless user.desired_labels.blank?
      user.desired_diets.map{ |dd|
        "<b>#{ link_to dd.name.downcase, search_path(search: [:diets,dd.name]) }</b>"
      }.join("<span style='color:#999'>/</span>").html_safe
    end
  end

  def desired_labels(user)
    unless user.desired_labels.blank?
      user.desired_labels.map{ |dd|
        "<b>#{ link_to dd.name.downcase, search_path(search: [:straightedgeness, dd.name]) }</b>"
      }.join("<span style='color:#999'>/</span>").html_safe
    end
  end

end
