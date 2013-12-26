require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    describe "logged in" do
      let(:user) { create(:user) }
      before { session[:user_id] = user.id }
      it "calls viewable users on current user" do
        controller.stub(:current_user) { user }
        user.should_receive(:viewable_users).once.and_return(User.all)
        get :index
      end
    end
  end
  

end
