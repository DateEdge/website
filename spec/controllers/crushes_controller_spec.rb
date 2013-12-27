require 'spec_helper'

describe CrushesController do
  let!(:bookis) { create(:bookis) }
  let!(:shane)  { create(:shane)  }
  before { session[:user_id] = bookis.id }
  describe "POST 'create'" do
    it "creates a crush" do
      expect { post :create, username: shane.username }.to change(Crush, :count).by(1)
    end
  end
  
  describe "DELETE 'destroy'" do
    it "deletes a crush" do
      bookis.crushings.create(crushee_id: shane.id)
      expect { delete :destroy, username: shane.username }.to change(Crush, :count).by(-1)
    end
  end
end
