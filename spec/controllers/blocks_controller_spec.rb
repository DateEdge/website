require 'spec_helper'

describe BlocksController do
  let(:user) { create(:user) }
  before { sign_in }
  describe "POST 'create'" do
    let(:request) { post :create, block: {blocked_id: user.id} }
    it "creates a post" do
      expect {request}.to change(Block, :count).by(1)
    end
  end
  
  describe "DELETE 'destroy" do
    let(:block) { create(:block, blocker_id: session[:user_id]) }
    let(:request) { delete :destroy, id: block.id }
    
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
