class Message < ActiveRecord::Base
  attr_accessor :subject

  belongs_to :conversation
  belongs_to :sender,    class_name: "User"
  belongs_to :recipient, class_name: "User"

  before_save :create_conversation, unless: :conversation_id?

  scope :unread, -> { where(unread: true)  }
  scope :read,   -> { where(unread: false) }
  scope :received, lambda { |user| where(recipient_id: user.id) }
  
  private

  def create_conversation
    self.conversation = Conversation.create(subject: self.subject, recipient_id: self.recipient_id, user_id: self.sender_id)
  end

end
