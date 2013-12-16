require 'spec_helper'

describe ConversationsController do
  let(:user) { User.create(username: "Shane", name: "SB", email: "test@example.com", birthday: 15.years.ago, visible: true) }
  before { session[:user_id] = user.id }
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:user2) { User.create(username: "Bookis", name: "BS", email: "bs@example.com", birthday: 25.years.ago, visible: true) }
    let(:conversation) { user.conversations.create(user_id: user.id, recipient_id: user2.id, subject: "Blah") }
    
    it "should be successful" do
      get 'show', id: conversation.id
      response.should be_success
    end
  end

end
