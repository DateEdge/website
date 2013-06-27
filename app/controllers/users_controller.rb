class UsersController < ApplicationController
  skip_before_filter :restrict_non_visible_user, :only => [:new, :create]

  def index
    if logged_in?
      return redirect_to(root_path)
    end

    @title = "People Using Date Edge"
    @slug  = "people"
    @users = User.visible.in_my_age_group(current_user)
  end

  def show
    @slug  = "people"
    @user  = User.visible.where(['lower(username) = ?', params[:username].downcase]).first
    @title = "#{@user.username}&rsquo;s Profile on Date Edge"
    @crush = Crush.new

    redirect_if_age_inappropriate(@user)
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

    @user.attributes = params.require(:user).permit(:username, :email, "birthday(1i)", "birthday(2i)", "birthday(3i)")

    if @user.save
      @user.visiblize!
      redirect_to new_photo_path(:getting => "started")
    else
      render :new
    end
  end

  def edit
    @title = "Your Settings on Date Edge"
    @slug  = "settings"
    @user  = current_user
  end

  def update
    @user = current_user
    if current_user.update(user_params)
      redirect_to(person_path(current_user.username), :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # TODO implement
  # TODO is this done?
  # ***************************
  def destroy
    @user = current_user
    @user.destroy
    session.delete(:user_id)
    redirect_to root_path, :notice => "Profile Deleted. Come on back any time."
  end
  
  private 
  
  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
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
      your_labels_attributes: [:label_id, :id, :_destroy]
    )
  end
end
