module RedFlagsHelper
  def flagged?(obj)
    return unless current_user
    current_user.red_flag_reports.where(flaggable_id: obj.id, flaggable_type: obj.class.to_s).any?
  end
end
