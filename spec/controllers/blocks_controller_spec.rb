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
end
