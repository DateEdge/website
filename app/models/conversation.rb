class Conversation < ActiveRecord::Base

  default_scope joins(:messages).order('messages.updated_at desc')
  has_many :messages, :dependent => :destroy

  belongs_to :sender,     :foreign_key => :user_id,       :class_name => "User"
  belongs_to :recipient, :foreign_key => :recipient_id, :class_name => "User"

  def participants
    [sender, recipient]
  end

  def counterpart(user)
    p = participants
    p.delete user
    p.first
  end

  def self.unread_messages(user)
    user.conversations.all.uniq.map { |convo| convo.messages.where(:recipient_id => user.id).unread.count }.sum
  end

end
