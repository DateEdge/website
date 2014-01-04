class Admin::DashboardController < AdminController
  def index
    @users = User.order('created_at desc').paginate(page: params[:page] ||= 1)
  end
end