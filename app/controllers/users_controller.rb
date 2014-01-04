class UsersController < ApplicationController
  skip_before_filter :restrict_non_visible_user, only: [:new, :create]
  before_action :require_login, only: [:edit, :update, :destroy]

  def index
    @title = "People Using Date Edge"
    @slug  = "people"
    @users = if logged_in?
      current_user.viewable_users
    else
      User.visible
    end

    @users = @users.order('created_at desc').paginate(page: params[:page] ||= 1)
  end

  def show
    @slug  = "people"
    find_user_by_username
    if @user
      @title = "#{@user.username}&rsquo;s Profile on Date Edge"
      @crush = Crush.new

      redirect_if_age_inappropriate(@user)
    else
      redirect_to root_path, notice: "That user doesn't exist."
    end
  end

  def new
    @slug  = "settings"
    @title = "Getting Started on Date Edge"
    @user  = current_user

    if @user.nil? or @user.visible?
      return redirect_to(root_path)
    end
  end

  def create
    @user = current_user
    params[:user][:username] = User.generate_username if params[:user][:username].blank?
    if @user.update(params.require(:user).permit(:username, :email, "birthday(1i)", "birthday(2i)", "birthday(3i)", :agreed_to_terms_at))
      @user.visiblize!
      redirect_to new_photo_path(getting: "started")
    else
      render :new
    end
  end

  def edit
    @title = "Your Settings on Date Edge"
    @slug  = "settings"
    @user  = current_user
    @label_assignements = @user.your_labels.label_assignments
  end

  def update
    @user = current_user
    if current_user.update(user_params)
      redirect_to(person_path(current_user.username), notice: "Your settings were successfully updated.")
    else
      @label_assignements = @user.your_labels.label_assignments
      render action: "edit"
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Profile deleted. We'll miss you. Come on back any time."
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :birthday_public,
      :real_name_public,
      :email_public,
      "birthday(1i)",
      "birthday(2i)",
      "birthday(3i)",
      :city,
      :state_id,
      :zipcode,
      :country_id,
      :bio,
      :diet_id,
      :me_gender,
      :you_gender,
      :label_id,
      your_labels_attributes: [:label_id, :id, :_destroy, :label_type]
    )
  end
end
