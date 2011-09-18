class ConversationsController < ApplicationController
  def index
    @slug = "messages"
    @conversations = current_user.conversations.uniq
  end

  def show
    @conversation = current_user.conversations.where(:id => params[:id]).first
    
    if @conversation.nil?
      redirect_to root_path 
    elsif @conversation.messages.any? { |msg| msg.unread && msg.recipient_id == current_user.id}
      @conversation.messages.where(:recipient_id => current_user.id).update_all(:unread => false)
    end

  end

end
