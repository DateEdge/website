require 'spec_helper'

describe MessagesController do
  let(:user)  { create(:shane) }
  let(:user2) { create(:bookis) }
  let(:conversation) { user.outbound_conversations.create(recipient: user2) }
  
  before do 
    DatabaseCleaner.clean
    session[:user_id] = user.id 
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new', conversation_id: conversation.id
      response.should be_success
    end
    
    it "is not success if current user age inappropriate" do
      conversation
      user.update(birthday: 17.years.ago)
      get :new, conversation_id: conversation.id
      expect(response).to redirect_to people_path
    end
    
    it "is not success if recipient age inappropriate" do
      conversation
      user2.update(birthday: 17.years.ago)
      get :new, conversation_id: conversation.id
      expect(response).to redirect_to people_path
    end

    it "is not success if recipient age inappropriate with new convo" do
      user2.update(birthday: 17.years.ago)
      get :new, recipient: user2.id
      expect(response).to redirect_to people_path
    end
    
    it "redirects to people if it's not their convo" do
      conversation.update(sender: user2)
      get :new, conversation_id: conversation.id
      expect(response).to redirect_to conversations_path
    end
    
    
  end

  describe "POST 'create'" do
    it "should be successful" do
      post 'create', message: {body: "Body", subject: "Subject", recipient_id: user2.id, conversation_id: conversation.id}
      response.should redirect_to conversation_path(conversation.id)
    end
    
    it "is not success if age inappropriate" do
      user.update(birthday: 17.years.ago)
      post 'create', message: {body: "Body", subject: "Subject", recipient_id: user2.id, conversation_id: conversation.id}
      expect(response).to redirect_to conversations_path
      expect(flash[:notice]).to include 'You can\'t send a message to that user'
    end
    
    describe "blocked" do
      it "should redirect back to the convo" do
        create(:block, blocker_id: user.id, blocked_id: user2.id)
        post 'create', message: {body: "Body", subject: "Subject", recipient_id: user2.id, conversation_id: conversation.id}
        expect(response).to redirect_to conversations_path
        expect(flash[:notice]).to include "@#{user2.username} is not available to message"
      end
    end
  end

end
