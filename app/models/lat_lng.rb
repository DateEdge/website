class LatLng < ActiveRecord::Base
  belongs_to :user

  validates :user_id, uniqueness: true
  validates :user_id, :lat, :lng, :location, :avatar, presence: true
  scope :visible, -> { includes(:user).where(users: {visible: true}).references(:users) }
  scope :adults, -> { includes(:user).where(['users.birthday >= ?', 18.years.ago]).references(:users) }
  scope :kids,   -> { includes(:user).where(['users.birthday <  ?', 18.years.ago]).references(:users) }

  def map_data
    [lat.to_f, lng.to_f, username, avatar, location, user_id]
  end

end
