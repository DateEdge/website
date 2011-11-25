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

    @user.username   = params[:user].delete(:username)
    @user.email      = params[:user].delete(:email)
    @user.attributes = params[:user]

    if @user.save
      @user.visiblize!
      redirect_to new_photo_path
    else
      render :new
    end
  end

  def edit
    @title = "Settings on Date Edge"
    @slug  = "settings"
    @user  = current_user
  end

  def update
    @user = current_user
    params[:user][:your_labels_attributes].delete_if {|k, v| v['label_id'] == "0"}

    if current_user.username
      params[:user].delete(:username)
    end

    if current_user.update_attributes(params[:user])
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
end
