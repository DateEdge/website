class CrushesController < ApplicationController
  before_action :require_login

  def create
    user = User.find_by(username: params[:username])
    crush = current_user.crushings.build(crushee: user)
    redirect_if_age_inappropriate(crush.crushee)
    crush.save!
    redirect_to person_path(crush.crushee.username)
  end

  def destroy
    user = User.find_by(username: params[:username])
    current_user.crushings.where(crushee_id: user.id).destroy_all
    redirect_to person_path(user.username)
  end

end
