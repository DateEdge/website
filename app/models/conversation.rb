class Conversation < ActiveRecord::Base

  default_scope joins(:messages).order('messages.updated_at desc')
  has_many :messages

  belongs_to :sender,     :foreign_key => :user_id,       :class_name => "User"
  belongs_to :recipient, :foreign_key => :recipient_id, :class_name => "User"

  def participants
    [sender, recipient]
  end

  def counterpart(user)
    participants.delete user
  end
end
