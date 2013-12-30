class Conversation < ActiveRecord::Base

  default_scope { order 'updated_at desc'}
  has_many :messages, dependent: :destroy

  belongs_to :sender,    foreign_key: :user_id,      class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"
  validates_with AgeAppropriateValidator

  scope :with_user, lambda { |user| where(['conversations.user_id = :id OR conversations.recipient_id = :id', id: user.id]).order("updated_at desc") }
  
  def participants
    [sender, recipient]
  end

  def counterpart(user)
    p = participants
    p.delete user
    p.first
  end

  def unread(user)
    messages.where(recipient_id: user.id).unread
  end

  def unread?(user)
    unread(user).any?
  end

  def self.unread_messages(user)
    user.conversations.all.uniq.map { |convo| convo.messages.received(user).unread.count }.sum
  end

end
