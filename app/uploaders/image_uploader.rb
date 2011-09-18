class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  storage :fog

  def store_dir
    "uploads/photos/users/#{model.user.id}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  def thumbnail(width, height)
    manipulate! do |img|
      img = img.crop(Magick::GravityType.new("CenterGravity", 5), width, height)
    end
  end
  
  version :tiny do
    process :thumbnail => [40, 40]
  end

  version :avatar do
    process :thumbnail => [130, 130]
  end

  version :large do
    process :resize_to_limit => [1000, 1000]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
     if original_filename
       extension = original_filename.split(".").last
       "photo.#{extension}"
     end
  end

end
