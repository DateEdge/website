class Message < ActiveRecord::Base
  attr_accessor :subject
  default_scope order("created_at desc")

  belongs_to :conversation
  belongs_to :sender,     :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  before_save :create_conversation, :unless => :conversation_id?

  private

  def create_conversation
    self.conversation = Conversation.create(:subject => self.subject, :recipient_id => self.recipient_id, :user_id => self.sender_id)
  end
end
