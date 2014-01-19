class Bookmark < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :bookmarkee, class_name: "User", touch: true
  
  validates :bookmarkee_id, :user_id, presence: true
end
