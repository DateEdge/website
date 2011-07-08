class UsersController < ApplicationController
  skip_before_filter :restrict_non_visible_user, :only => [:new, :create]

  def index
    @users = User.in_my_age_group(current_user)
  end

  def show
    @user  = User.visible.where(['lower(username) = ?', params[:username].downcase]).first
    @crush = Crush.new

    if @user.nil? || @user.age_inappropiate?(current_user)
      redirect_to people_path
    end
  end

  def new
    @user = current_user
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
    @user = current_user
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
  def destroy; end
end
