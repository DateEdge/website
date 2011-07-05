class CrushesController < ApplicationController
  
  def create
    crush = current_user.crushings.create(params[:crush])
    redirect_to person_path(crush.crushee.username)
  end
  
end
