class Message < ActiveRecord::Base
  attr_accessor :subject

  belongs_to :conversation, touch: true
  belongs_to :sender,    class_name: "User"
  belongs_to :recipient, class_name: "User"
  validates_with AgeAppropriateValidator
  validates_with BlockValidator
  validates :recipient_id, :sender_id, presence: true
  before_save :create_conversation, unless: :conversation_id?
  after_save :unhide_conversation
  scope :unread, -> { where(unread: true)  }
  scope :read,   -> { where(unread: false) }
  scope :received, lambda { |user| where(recipient_id: user.id) }
  
  private

  def create_conversation
    self.conversation = Conversation.create(subject: self.subject, recipient_id: self.recipient_id, user_id: self.sender_id)
  end
  
  def unhide_conversation
    self.conversation.unhide
  end

end
