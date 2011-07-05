class Photo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  after_save :check_avatar, :if => :avatar?

  private
  
  def check_avatar
    avatars = self.user.photos.where(:avatar => true).all
    avatars.delete(self)
    avatars.each { |avatar| avatar.update_attributes(:avatar => false)}
  end
end
