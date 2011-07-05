class UsersController < ApplicationController
  def index
    @users = User.in_my_age_group(current_user)
  end

  def show
    @user = User.where(:username => params[:username]).first

    unless @user.age_appropiate?(current_user)
      redirect_to people_path
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
end
