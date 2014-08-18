class LatLng < ActiveRecord::Base
  validates :user_id, uniqueness: true
  validates :user_id, :lat, :lng, :location, :avatar, presence: true
end
