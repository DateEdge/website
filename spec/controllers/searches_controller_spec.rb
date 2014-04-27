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
    
  end

end
