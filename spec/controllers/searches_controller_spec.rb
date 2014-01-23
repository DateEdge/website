require 'spec_helper'

describe SearchesController do
  let!(:shane) { create(:shane) }
  let!(:bookis) { create(:bookis, visible: true) }
  
  before { sign_in(shane) }
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', column: :diets
      response.should be_success
    end
    
    it "shows everyone" do
      get :show, search: "bookis"
      expect(assigns(:users)).to include bookis
    end

    it "doesn't show blocked people" do
      shane.blocks << Block.create(blocked_id: bookis.id)
      get :show, search: "bookis"
      expect(assigns(:users)).to_not include bookis
    end
    
    it "by username field" do
      User.should_receive(:search).with("username" => "veganstraightedge").once.and_return User.visible
      get :show, search: "username/veganstraightedge"
    end
  end

end
