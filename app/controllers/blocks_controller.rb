class BlocksController < ApplicationController
  def create
    @block = current_user.blocks.build(params.require(:block).permit(:blocked_id))
    if @block.save
      @user = @block.blocked_user
      redirect_to people_path, notice: "Blocked! #{@user.username} will no longer show in your feed."
    end
  end
  
  def destroy
    @block = current_user.blocks.find(params[:id])
    @user  = @block.blocked_user
    if @block.destroy
      redirect_to people_path, notice: "Un-blocked! #{@user.username} will now show in your feed."
    end
  end
end
