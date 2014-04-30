class RedFlag < ActiveRecord::Base
  belongs_to :flaggable, polymorphic: true
  belongs_to :reporter, class_name: "User"
  validates :flaggable_id, :reporter_id, presence: true
  validates :flaggable_id, uniqueness: {scope: [:reporter_id, :flaggable_type]}
end
