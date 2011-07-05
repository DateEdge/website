class ConversationsController < ApplicationController
  def index
  end

  def show
    @conversation = Conversation.find(params[:id])
  end

end
