class Photo < ActiveRecord::Base
  attr_accessor :manipulate
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  before_create :clean_url
  before_save :check_avatar
  before_save :process_manipulation, if: :manipulate

  private
  
  def process_manipulation
    return unless self.manipulate.respond_to? :has_key?
    self.image.manipulate! do |source|
      if self.manipulate.has_key? :rotate
        source.rotate(self.manipulate[:rotate].to_i)
      elsif self.manipulate.has_key? :flip
        source.flip!
      elsif self.manipulate.has_key? :flop
        source.flop!
      else 
        source
      end
    end
  end
  
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
