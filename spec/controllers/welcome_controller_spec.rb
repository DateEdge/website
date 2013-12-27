require 'spec_helper'

describe WelcomeController do
  let!(:user) { create(:user) }
  
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    describe "logged in" do
      before { session[:user_id] = user.id }
      it "calls viewable users on current user" do
        controller.stub(:current_user) { user }
        user.should_receive(:viewable_users).once.and_return(User.all)
        get :index
      end
      
      describe "blocks" do
        let!(:bookis) { create(:bookis) }
      
        it "shows bookis by default" do
          get :index
          expect(assigns(:users)).to include bookis
        end
      
        it "does not show bookis" do
          create(:block, blocker_id: user.id, blocked_id: bookis.id)
          get :index
          expect(assigns(:users)).to_not include bookis
        end

        it "does not show shane if bookis is logged in" do
          session[:user_id] = bookis.id
          create(:block, blocker_id: user.id, blocked_id: bookis.id)
          get :index
          expect(assigns(:users)).to_not include user
        end
      
        it "includes user by default" do
          session[:user_id] = bookis.id
          get :index
          expect(assigns(:users)).to include user
        end
      end
    end
  end
end
