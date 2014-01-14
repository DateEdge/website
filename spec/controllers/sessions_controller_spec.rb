require 'spec_helper'

describe SessionsController do
  describe "with facebook" do
    let(:auth) { OmniAuth.mock_auth_for(:facebook) }
    it "sign up creates a user" do
      controller.request.env.should_receive(:[]).with("omniauth.auth").once.and_return(auth)
      controller.request.env.should_receive(:[]).at_least(:once).and_call_original
      expect { get :create, provider: "facebook" }.to change(User, :count).by(1)
      expect(cookies[:auth_token]).to_not be_blank
    end
    
    it "signs in the user" do
      controller.request.env.should_receive(:[]).with("omniauth.auth").once.and_return(auth)
      controller.request.env.should_receive(:[]).at_least(:once).and_call_original
      user = User.create(username: "Shane", name: "SB", email: "test@example.com", birthday: 15.years.ago, agreed_to_terms_at: Time.now)
      user.providers << Provider.create(name: auth["provider"], uid: auth["uid"])
      expect { get :create, provider: "facebook" }.to change(User, :count).by(0)
      expect(cookies[:auth_token]).to_not be_blank
    end
  end
  
  describe "sign up with twitter" do
    it "is successful" do
      controller.request.env.should_receive(:[]).with("omniauth.auth").once.and_return(OmniAuth.mock_auth_for(:twitter))
      controller.request.env.should_receive(:[]).at_least(:once).and_call_original
      expect { get :create, provider: "twitter" }.to change(User, :count).by(1)
    end
  end
  
end
