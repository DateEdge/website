class BlocksController < ApplicationController
  def create
    @block = current_user.blocks.build(params.require(:block).permit(:blocked_id))
    if @block.save
      @user = @block.blocked_user
      redirect_to people_path, notice: "Blocked! #{@user.username} will no longer show in your feed."
    end
  end
end
