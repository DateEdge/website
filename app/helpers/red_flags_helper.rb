module RedFlagsHelper

  def flagged?(obj)
    return unless current_user
    current_user.red_flag_reports.where(flaggable_id: obj.id, flaggable_type: obj.class.to_s).any?
  end

  def unflag_button(obj, options={})
    flag = current_user.red_flag_reports.find_by(flaggable_id: obj.id, flaggable_type: obj.class.to_s)
    link_to "Unflag as inappropriate", flag_path(flag.id), {method: :delete}.merge(options)
  end

end
