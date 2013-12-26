class Block < ActiveRecord::Base
  belongs_to :user, foreign_key: :blocker_id
  belongs_to :blocked_user, foreign_key: :blocked_id, class_name: "User"
end
