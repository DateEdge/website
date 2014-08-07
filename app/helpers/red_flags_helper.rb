module RedFlagsHelper

  def flagged?(obj)
    return unless current_user
    current_user.red_flag_reports.where(flaggable_id: obj.id, flaggable_type: obj.class.to_s).any?
  end

  def unflag_button(obj, options={})
    flag = current_user.red_flag_reports.find_by(flaggable_id: obj.id, flaggable_type: obj.class.to_s)
    link_to "<i class='fa fa-flag'></i>&nbsp;&nbsp;Unflag as inappropriate".html_safe,
            flag_path(flag.id),
            { method: :delete }.merge(options)
  end

end
