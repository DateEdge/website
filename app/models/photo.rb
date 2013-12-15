class Photo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  before_create :clean_url
  after_save :check_avatar, if: :avatar?

  private
  
  def clean_url
    # TODO what's wrong with this?
    @remote_image_url = self.remote_image_url.gsub("+", "%20")
  end
  
  def check_avatar
    avatars = self.user.photos.where(avatar: true).all
    avatars.delete(self)
    avatars.each { |avatar| avatar.update_attributes(avatar: false)}
  end
end
