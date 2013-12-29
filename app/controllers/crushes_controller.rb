class CrushesController < ApplicationController
  before_action :require_login
  before_action :find_user_by_username

  def create
    crush = current_user.crushings.build(crushee: @user)
    unless redirect_if_age_inappropriate(crush.crushee)
      crush.save!
      redirect_to person_path(crush.crushee.username)
    end
  end

  def destroy
    find_user_by_username
    current_user.crushings.where(crushee_id: @user.id).destroy_all
    redirect_to person_path(@user.username)
  end

end
