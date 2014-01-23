require 'spec_helper'

describe CrushesController do
  let!(:bookis) { create(:bookis) }
  let!(:shane)  { create(:shane)  }
  before { sign_in(bookis) }
  describe "POST 'create'" do
    it "creates a crush" do
      expect { post :create, username: shane.username }.to change(Crush, :count).by(1)
    end
    
    it "redirects if the user is age inappropriate" do
      bookis.update(birthday: 17.years.ago)
      post :create, username: shane.username
      expect(response).to redirect_to people_path
    end
  end
  
  describe "DELETE 'destroy'" do
    it "deletes a crush" do
      bookis.crushings.create(crushee_id: shane.id)
      expect { delete :destroy, username: shane.username }.to change(Crush, :count).by(-1)
    end
  end
end
