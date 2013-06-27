class CrushesController < ApplicationController

  def create
    crush = current_user.crushings.new(params.require(:crush).permit(:crushee_id, :secret))
    redirect_if_age_inappropriate(crush.crushee)
    crush.save!
    redirect_to person_path(crush.crushee.username)
  end

  def destroy
    crush  = Crush.where(:id => params[:id]).first
    person = crush.crushee.username
    crush.destroy
    redirect_to person_path(person)
  end

end
