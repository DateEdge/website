class PhotosController < ApplicationController
  
  def new
    @user = current_user
    @photo = current_user.photos.new
  end
  
  def create
    @photo = current_user.photos.new(params[:photo])
    if @photo.save
      redirect_to person_path(current_user.username)
    else
      render :new
    end
  end

  def edit
  end
  
  def destroy
    photo = Photo.find(params[:id])
    
    if photo.user == current_user
      photo.destroy
      redirect_to person_path(current_user.username)
    else
      redirect_to root_path
    end
  end

end
