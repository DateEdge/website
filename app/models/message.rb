class Message < ActiveRecord::Base

  default_scope order("created_at desc")

  belongs_to :sender,     :class_name => "User"
  belongs_to :receipient, :class_name => "User"

end
