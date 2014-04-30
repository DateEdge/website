class RedFlagsController < ApplicationController
  
  def create
    flag = current_user.red_flag_reports.new(flaggable_id: params[:id], flaggable_type: params.require(:red_flag)[:flaggable_type])
    flash[:notice] = flag.save ? "Flagged!" : "Already flagged"
    user = flag.flaggable_type == "User" ? flag.flaggable : flag.flaggable.user
    redirect_to user
  end
end
