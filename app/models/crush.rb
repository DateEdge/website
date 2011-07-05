class Crush < ActiveRecord::Base
  belongs_to :crusher, :class_name => "User"
  belongs_to :crushee, :class_name => "User"
end
