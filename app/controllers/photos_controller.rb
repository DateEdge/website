class PhotosController < ApplicationController

  before_action :set_photo,                     only: [:edit, :update, :destroy]
  before_action :confirm_photo_belongs_to_user, only: [:edit, :update, :destroy]
  
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
  end

  def update
    @photo.update(photos_params)
    redirect_to person_path(current_user.username)
  end

  def destroy
   @photo.destroy
   redirect_to person_path(current_user.username)
  end
  
  private
  
  def set_photo
    @photo = Photo.find(params[:id])
  end
  
  def confirm_photo_belongs_to_user
    unless @photo.user == current_user
      redirect_to root_path, notice: "Oops, not your photo :("
    end
  end
  
  def photos_params
    params.require(:photo).permit(:remote_image_url, :caption, :image, :avatar)
  end

end
