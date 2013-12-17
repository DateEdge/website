class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmarkee, class_name: "User"
  
  validates :bookmarkee_id, :user_id, presence: true
end
