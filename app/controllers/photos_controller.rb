class PhotosController < ApplicationController

  def new
    @slug  = "settings"
    @title = "Photo Uploader on Date Edge"
    @user  = current_user
    @photo = Photo.new
  end

  def create
    params[:photo][:remote_image_url].gsub!('+', '%20')
    @photo = current_user.photos.new(photos_params)
    if @photo.save
      redirect_to person_path(current_user.username)
    else
      render :new
    end
  end

  def edit
    @slug  = "settings"
    @title = "Photo Editor on Date Edge"
    @photo = Photo.find(params[:id])

    unless @photo.user == current_user
      redirect_to root_path
    end
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photos_params)
    redirect_to person_path(current_user.username)
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
  
  private
  
  def photos_params
    params.require(:photo).permit(:remote_image_url, :caption, :image, :avatar)
  end

end
