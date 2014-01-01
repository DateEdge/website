require 'spec_helper'

describe ConversationsController do
  let(:user) { create(:bookis) }
  let(:shane) { create(:shane) }
  let(:conversation) { user.conversations.create(user_id: user.id, recipient_id: shane.id, subject: "Blah") }
  before { session[:user_id] = user.id }
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      conversation
      get 'show', username: shane.username
      response.should be_success
      expect(assigns(:conversation)).to eq conversation
    end
  end
  
  describe "DELETE 'destroy'" do
    it "deletes the convo" do
      conversation
      delete :destroy, username: shane.username
      expect { conversation.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end
