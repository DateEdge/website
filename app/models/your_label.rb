class YourLabel < ActiveRecord::Base
  belongs_to :user
  belongs_to :label
  validates  :user,  presence: true
  validates  :label, presence: true
  validates  :label_id, uniqueness: { scope: :user_id }
end
