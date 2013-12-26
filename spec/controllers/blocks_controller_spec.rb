require 'spec_helper'

describe BlocksController do
  let(:user) { create(:user) }
  before { sign_in }
  describe "POST 'create'" do
    let(:request) { post :create, username: user.username }
    it "creates a post" do
      expect {request}.to change(Block, :count).by(1)
    end
  end
  
  describe "DELETE 'destroy" do
    let(:block) { create(:block, blocker_id: session[:user_id], blocked_id: user.id) }
    let(:request) { delete :destroy, username: user.username }
    
    it "redirect to people path" do
      request
      expect(response).to redirect_to people_path
    end
    
    it "deletes the post" do
      block
      expect { request }.to change(Block, :count).by(-1)
    end
  end
end
