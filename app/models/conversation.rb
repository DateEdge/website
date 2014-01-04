class Conversation < ActiveRecord::Base

  default_scope { order 'updated_at desc'}
  has_many :messages, dependent: :destroy, after_add: :unhide

  belongs_to :sender,    foreign_key: :user_id,      class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"
  validates_with AgeAppropriateValidator

  scope :with_user,   lambda { |user| where(['conversations.user_id = :id OR conversations.recipient_id = :id', id: user.id]).order("updated_at desc") }
  scope :not_deleted, lambda { |user| where("conversations.hidden_from_user_id IS NULL OR conversations.hidden_from_user_id != :id", id: user.id)}
  def participants
    [sender, recipient]
  end
  
  def delete_from_user(user)
    if hidden_from_user_id? && participants.include?(user)
      self.destroy
    else
      update(hidden_from_user_id: user.id)
    end
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

  private
  
  def unhide(message)
    self.update(hidden_from_user_id: nil) if hidden_from_user_id?
  end
end
