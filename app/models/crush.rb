class Crush < ActiveRecord::Base
  belongs_to :crusher, class_name: "User", touch: true
  belongs_to :crushee, class_name: "User", touch: true

  scope :today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
end
