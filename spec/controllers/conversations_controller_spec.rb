require 'spec_helper'

describe ConversationsController do
  let(:user) { create(:bookis) }
  before { session[:user_id] = user.id }
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:shane) { create(:shane) }
    let(:conversation) { user.conversations.create(user_id: user.id, recipient_id: shane.id, subject: "Blah") }
    
    it "should be successful" do
      conversation
      get 'show', username: shane.username
      response.should be_success
      expect(assigns(:conversation)).to eq conversation
    end
  end

end
