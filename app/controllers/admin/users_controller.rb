class Admin::UsersController < AdminController
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit!)
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  def index
  end
end
