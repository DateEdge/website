class Crush < ActiveRecord::Base
  belongs_to :crusher, class_name: "User", touch: true
  belongs_to :crushee, class_name: "User", touch: true
end
