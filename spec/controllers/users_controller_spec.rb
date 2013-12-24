require 'spec_helper'

describe UsersController do
  let!(:user) { User.create(username: "Shane", name: "SB", email: "test@example.com", birthday: 15.years.ago, agreed_to_terms_at: Time.now, visible: true) }

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', username: "Shane"
      response.should be_success
    end
    
    it "redirect to home if the user doesn't exit" do
      get :show, username: "imnotreal"
      expect(response).to redirect_to root_path
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
  
  describe "POST 'create'" do
    let(:user) { User.create(name: "Bookis", username: "Bookis") }
    before { sign_in(user) }
    
    it "redirects to people path" do
      post :create, user: {username: User.generate_username, email: "b@c.com", "birthday(1i)" => 2013,"birthday(2i)" => 1,"birthday(3i)" => 1, agreed_to_terms_at: Time.now}
      expect(response).to redirect_to new_photo_path(getting: "started")
    end
    
    it "changes user visibility" do
      post :create, user: {username: User.generate_username, email: "b@c.com", "birthday(1i)" => 2013,"birthday(2i)" => 1,"birthday(3i)" => 1, agreed_to_terms_at: Time.now}
      user.reload
      expect(user.visible).to be_true
    end
    
    it "renders the edit form if there are errors" do
      post :create, user: {username: User.generate_username, email: "b@c.com", "birthday(1i)" => 2013,"birthday(2i)" => 1,"birthday(3i)" => 1}
      expect(response).to render_template :new
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
    
    it "updates settings" do
      patch :update, user: {birthday_public: true, admin: true }
      expect(assigns(:user).birthday_public?).to be_true
      expect(assigns(:user).admin?).to be_nil
    end
    
  end
  
  describe "subject" do
    
  end

end
