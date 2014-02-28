class Photo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  before_create :clean_url
  before_save :check_avatar

  private
  
  def clean_url
    self.remote_image_url.gsub!("+", "%20") if self.remote_image_url
  end
  
  def check_avatar
    avatars = self.user.photos.where(avatar: true)
    avatars.to_a.delete(self)
    if avatars.empty?
      self.avatar = true
    elsif avatar
      avatars.each { |avatar| avatar.update_attributes(avatar: false)}
    end
  end
end
