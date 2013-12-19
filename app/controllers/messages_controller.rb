class MessagesController < ApplicationController
  before_action :require_login

  def new
    @slug  = "messages"
    @title = "Messenger on Date Edge"

    if params["recipient"].present?
      @conversation = Conversation.new
      @user = User.find_by(username: params["recipient"])
    else
      @conversation = current_user.outbound_conversations.find(params[:conversation_id])
      @user = @conversation.counterpart(current_user)
    end
    redirect_if_age_inappropriate(@user)
    @message = @conversation.messages.build(recipient: @user)
  rescue ActiveRecord::RecordNotFound
    redirect_to conversations_path
  end

  def create
    message = current_user.outbound_messages.build(messages_params)
    if message.save
      redirect_to conversation_path(message.conversation)
    elsif message.errors.has_key? :restricted
      redirect_to people_path, notice: message.errors[:restricted]
    else
      render :new
    end
  end
  
  private
  
  def messages_params
    params.require(:message).permit(:body, :subject, :recipient_id, :conversation_id)
  end
end
