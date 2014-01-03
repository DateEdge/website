require 'spec_helper'

describe ConversationsController do
  let(:shane)  { User.create(username: "Shane",  name: "SB", email: "test@example.com", birthday: 25.years.ago, visible: true, agreed_to_terms_at: Time.now) }
  let(:user) { User.create(username: "Bookis", name: "BS", email: "bs@example.com",   birthday: 25.years.ago, visible: true, agreed_to_terms_at: Time.now) }
  let!(:conversation) { user.conversations.create(user_id: user.id, recipient_id: shane.id, subject: "Blah") }
  before { session[:user_id] = user.id }
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      get 'show', username: shane.username
      response.should be_success
      expect(assigns(:conversation)).to eq conversation
    end
  end
  
  describe "DELETE 'destroy'" do
    let(:request) { delete :destroy, username: shane.username }
    it "updates the conversations" do
      request
      conversation.reload
      expect(conversation.hidden_from_user_id).to eq user.id
    end
    
    it "deletes the convo for one persone" do
      request
      get 'show', username: shane.username
      expect(response).to redirect_to root_path
    end
    
    it "loads show for other user" do
      request
      controller.stub(:current_user) { shane }
      get :show, username: user.username
      expect(response).to be_successful
    end
  end

end
