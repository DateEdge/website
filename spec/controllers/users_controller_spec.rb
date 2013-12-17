require 'spec_helper'

describe UsersController do
  let!(:user) { User.create(username: "Shane", name: "SB", email: "test@example.com", birthday: 15.years.ago, agreed_to_terms_at: Time.now, visible: true) }

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', username: "Shane"
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    before { 
      user.stub(:visible) { true }
      session[:user_id] = user.id 
    }
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end
  
  describe "PATCH 'update'" do
    before { 
      user.stub(:visible) { true }
      session[:user_id] = user.id 
    }
    
    it "updates name" do
      patch :update, user: {name: "BKS"}
      expect(response).to redirect_to person_path(user.username)
    end
    
    it "doesn't update username" do
      expect { patch :update, user: {username: "BKS"} }.to_not change(user, :username)
    end
    
    it "doesn't update email" do
      expect { patch :update, user: {email: "b@example.com"} }.to_not change(user, :email)
    end
    
  end

end
