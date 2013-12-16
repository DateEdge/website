class ConversationsController < ApplicationController
  def index
    @title = "Inbox on Date Edge"
    @slug  = "messages"
    @conversations = current_user.conversations.uniq
  end

  def show
    @slug         = "messages"
    @conversation = current_user.conversations.where(id: params[:id]).first
    @avatar_size  = "tiny"
    @message      = Message.new(recipient_id:    @conversation.counterpart(current_user).id,
                                conversation_id: @conversation.id)

    unless @conversation.nil?
      @title = "&ldquo;#{@conversation.subject}&rdquo; Conversation
                with #{@conversation.counterpart(current_user).username} on Date Edge"
    end

    if @conversation.nil?
      redirect_to root_path
    elsif @conversation.messages.any? { |msg| msg.unread && msg.recipient_id == current_user.id}
      @conversation.messages.where(recipient_id: current_user.id).update_all(unread: false)
    end
  end
end
