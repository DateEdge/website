class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.uniq
  end

  def show
    @conversation = Conversation.find(params[:id])
    if @conversation.messages.any? { |msg| msg.unread && msg.recipient_id == current_user.id}
      @conversation.messages.where(:recipient_id => current_user.id).update_all(:unread => false)
    end

    unless @conversation.participants.include? current_user
      redirect_to root_path
    end
  end

end
