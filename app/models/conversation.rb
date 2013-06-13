class Conversation < ActiveRecord::Base

  # TODO FIXME was causing a 500 on heroku but not locally, commented out for now
  # default_scope joins(:messages).order('messages.updated_at asc')
  has_many :messages, :dependent => :destroy

  belongs_to :sender,    :foreign_key => :user_id,      :class_name => "User"
  belongs_to :recipient, :foreign_key => :recipient_id, :class_name => "User"

  def participants
    [sender, recipient]
  end

  def counterpart(user)
    p = participants
    p.delete user
    p.first
  end

  def unread(user)
    messages.where(:recipient_id => user.id).unread
  end

  def unread?(user)
    unread(user).any?
  end

  def self.unread_messages(user)
    user.conversations.all.uniq.map { |convo| convo.messages.received(user).unread.count }.sum
  end

end
