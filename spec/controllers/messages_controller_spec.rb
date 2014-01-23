require 'spec_helper'

describe MessagesController do
  let(:user)  { create(:shane) }
  let(:user2) { create(:bookis) }
  let(:conversation) { user.outbound_conversations.create(recipient: user2) }
  let(:request) { get 'new', username: user2.username }
  before do 
    DatabaseCleaner.clean
    session[:user_id] = user.id 
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      request
      response.should be_success
    end
    
    it "is not success if current user age inappropriate" do
      user.update(birthday: 17.years.ago)
      request
      expect(response).to redirect_to people_path
    end
    
    it "is not success if recipient age inappropriate" do
      user2.update(birthday: 17.years.ago)
      request
      expect(response).to redirect_to people_path
    end
    
    it "assigns the correct conversation" do
      conversation
      request
      expect(assigns(:conversation)).to eq conversation
    end

    it "is not success if recipient age inappropriate with new convo" do
      user2.update(birthday: 17.years.ago)
      request
      expect(response).to redirect_to people_path
    end
    
    it "Renders a new conversation" do
      conversation.update(sender: create(:user))
      request
      expect(response).to be_successful
    end
    
    
  end

  describe "POST 'create'" do
    it "should be successful" do
      post 'create', username: user2.username, message: {body: "Body"}
      response.should redirect_to conversation_path(user2.username)
    end
    
    it "is not success if age inappropriate" do
      user.update(birthday: 21.years.ago)
      user2.update(birthday: 10.years.ago)
      post 'create', username: user2.username, message: {body: "Body"}
      expect(response).to redirect_to conversations_path
      expect(flash[:notice]).to include 'You can\'t send a message to that user'
    end
    
    describe "blocked" do
      it "should redirect back to the convo" do
        User.any_instance.stub(:block_with_user?) { true }
        post 'create', username: user2.username, message: {body: "Body"}
        expect(response).to redirect_to conversations_path
        expect(flash[:notice]).to include "@#{user2.username} is not available to message"
      end
    end
  end

end
