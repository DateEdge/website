class Photo < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :image, 
                    :styles => { :large => "800x800>", :medium => "500x500>", :small => "150x150>", :avatar => "50x50#" },
                    :storage => :s3,
                    :path => ":attachment/:id/:style.:extension",
                    :s3_credentials => "#{Rails.root}/config/s3_credentials.yml",
                    :s3_protocol => 'https'
  
end
