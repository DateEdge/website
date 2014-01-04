require 'spec_helper'

describe ConversationsController do
  let(:shane)  { User.create(username: "Shane",  name: "SB", email: "test@example.com", birthday: 25.years.ago, visible: true, agreed_to_terms_at: Time.now) }
  let(:user) { User.create(username: "Bookis", name: "BS", email: "bs@example.com",   birthday: 25.years.ago, visible: true, agreed_to_terms_at: Time.now) }
  let!(:conversation) { user.conversations.create(user_id: user.id, recipient_id: shane.id) }
  before { session[:user_id] = user.id }
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "doesn't show it if they have deleted it" do
      conversation.delete_from_user(user)
      get :index
      expect(assigns(:conversations)).to_not include conversation
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
    
    it "actually deletes the convo" do
      request
      controller.stub(:current_user) { shane }
      expect { delete :destroy, username: user.username }.to change(Conversation, :count).by(-1)
    end
    
    it "doesn't actually delete a convo if the same person delete it twice" do
      request
      expect { delete :destroy, username: shane.username }.to_not change(Conversation, :count).by(-1)
    end
    
    it "deletes the convo for one person" do
      request
      get 'show', username: shane.username
      expect(response).to be_successful
    end
    
    it "loads show for other user" do
      request
      controller.stub(:current_user) { shane }
      get :show, username: user.username
      expect(response).to be_successful
    end
  end

end
