class BlocksController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    @block = current_user.blocks.build(blocked_user: @user)
    if @block.save
      redirect_to people_path, notice: "Blocked! #{@user.username} will no longer show in your feed."
    end
  end
  
  def destroy
    @user = User.find_by(username: params[:username])
    @block = current_user.blocks.where(blocked_id: @user.id)
    if @block.destroy_all
      redirect_to people_path, notice: "Un-blocked! #{@user.username} will now show in your feed."
    end
  end
end
