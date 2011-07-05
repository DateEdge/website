class MessagesController < ApplicationController
  def new
    if params["recipient"].present?
      # make sure the user is age appropiate
      @conversation = Conversation.new
      @user = User.where(:username => params["recipient"]).first
    else
      # make sure the user is authorized to see this conversation
      @conversation = Conversation.find(params[:conversation_id])
      @user = @conversation.counterpart(current_user)
    end

    @message = @conversation.messages.build(:recipient => @user)
  end

  def create
    message = Message.create!(params[:message].merge!(:sender => current_user))
    redirect_to conversation_path(message.conversation)
  end
end
