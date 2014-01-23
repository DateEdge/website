require 'spec_helper'

describe UsersController do
  let!(:shane) { create(:shane) }
  describe "GET 'index'" do
    let!(:bookis) { create(:bookis, visible: true) }
    before { session[:user_id] = shane.id }
    
    it "redirects to root" do
      get :index
      expect(response).to be_successful
    end
    
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get 'show', username: "veganstraightedge"
      response.should be_success
    end
    
    it "redirect to home if the user doesn't exit" do
      get :show, username: "imnotreal"
      expect(response).to redirect_to root_path
    end
    
  end

  describe "GET 'edit'" do
    before { 
      shane.stub(:visible) { true }
      session[:user_id] = shane.id 
    }
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end
  
  describe "DELETE 'destroy" do
    let(:bookis) { create(:bookis, visible: true, agreed_to_terms_at: Time.now) }
    before { sign_in(bookis) }
    it "destroys a user" do
      expect { delete :destroy, username: "@bookis" }.to change(User, :count).by(-1)
    end
    
    it "redirects to home" do
      delete :destroy, username: "@bookis"
      expect(response).to redirect_to root_path
    end
  end
  
  describe "POST 'create'" do
    let(:bookis) { create(:bookis, visible: false, agreed_to_terms_at: nil, email: nil, birthday: nil) }
    before { sign_in(bookis) }
    
    it "redirects to people path" do
      post :create, user: {username: User.generate_username, email: "b@c.com", "birthday(1i)" => 2013,"birthday(2i)" => 1,"birthday(3i)" => 1, agreed_to_terms_at: Time.now}
      expect(response).to redirect_to new_photo_path(getting: "started")
    end
    
    it "changes user visibility" do
      post :create, user: {username: User.generate_username, email: "b@c.com", "birthday(1i)" => 2013,"birthday(2i)" => 1,"birthday(3i)" => 1, agreed_to_terms_at: Time.now}
      bookis.reload
      expect(bookis.visible).to be_true
    end
    
    it "renders the edit form if there are errors" do
      post :create, user: {username: User.generate_username, email: "b@c.com", "birthday(1i)" => 2013,"birthday(2i)" => 1,"birthday(3i)" => 1}
      expect(response).to render_template :new
    end
  end
  
  describe "PATCH 'update'" do
    before { 
      shane.stub(:visible) { true }
      session[:user_id] = shane.id 
    }
    
    it "updates name" do
      patch :update, user: {name: "BKS"}
      expect(response).to redirect_to person_path(shane.username)
    end
    
    it "doesn't update username" do
      expect { patch :update, user: {username: "BKS"} }.to_not change(shane, :username)
    end
    
    it "doesn't update email" do
      expect { patch :update, user: {email: "b@example.com"} }.to_not change(shane, :email)
    end
    
    it "updates settings" do
      patch :update, user: {birthday_public: true, admin: true }
      expect(assigns(:user).birthday_public?).to be_true
      expect(assigns(:user).admin?).to be_nil
    end
  end
  
end
