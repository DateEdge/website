class CrushesController < ApplicationController
  
  def create
    crush = current_user.crushings.new(params[:crush])
    redirect_if_age_inappropriate(crush.crushee)
    crush.save!
    redirect_to person_path(crush.crushee.username)
  end
  
end
