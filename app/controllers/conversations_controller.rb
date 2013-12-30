class ConversationsController < ApplicationController
  before_action :require_login
  
  def index
    @title = "Inbox on Date Edge"
    @slug  = "messages"
    @conversations = current_user.conversations.uniq
  end

  def show
    find_user_by_username
    @slug         = "messages"
    @conversation = current_user.conversations.with_user(@user).first
    if @conversation.nil?
      redirect_to root_path
    elsif @conversation.messages.any? { |msg| msg.unread && msg.recipient_id == current_user.id}
      @conversation.messages.where(recipient_id: current_user.id).update_all(unread: false)
    end
    @title = "&ldquo;#{@conversation.subject}&rdquo; Conversation
              with #{@conversation.counterpart(current_user).username} on Date Edge"
    @messages     = @conversation.messages.order('created_at asc')
    @avatar_size  = "tiny"
    @message      = current_user.outbound_messages.build(recipient_id: @user.id, conversation_id: @conversation.id)
  end
end
