require 'spec_helper'

describe MessagesController do
  let(:user) { User.create(:username => "Shane", :name => "SB", :email => "test@example.com", :birthday => 25.years.ago, visible: true) }
  let(:user2) { User.create(:username => "Bookis", :name => "BS", :email => "bs@example.com", :birthday => 25.years.ago, visible: true) }
  let(:conversation) { Conversation.create }
  
  before do 
    DatabaseCleaner.clean
    session[:user_id] = user.id 
    Conversation.stub(:find) { conversation }
    Conversation.any_instance.stub(:counterpart).with(user) { user2 }
    User.stub(:where) { user2 }
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      post 'create', message: {body: "Body", subject: "Subject", receipient_id: user2.id, conversation_id: conversation.id}
      response.should redirect_to conversation_path(conversation.id)
    end
  end

end
