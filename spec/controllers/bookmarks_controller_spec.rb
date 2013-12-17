require 'spec_helper'

describe BookmarksController do
  let(:user) { User.create(username: "Shane", name: "SB", email: "test@example.com", birthday: 15.years.ago, agreed_to_terms_at: Time.now, visible: true) }
  
  before { 
    user.stub(:visible) { true }
    session[:user_id] = user.id 
  }
  
  describe "POST 'create'" do
    let(:request) { post :create, bookmark: {bookmarkee_id: 1} }
    before do
      Bookmark.any_instance.stub_chain(:bookmarkee, :username) { "Bookis" }
    end
    it "redirects" do
      request
      expect(response).to redirect_to person_path("Bookis")
    end
    
    it "creates a bookmark" do
      expect { request }.to change(user.bookmarks, :count).by(1)
    end

    it "creates a bookmark" do
      request
      expect(flash[:notice]).to include "Added bookmark"
    end
    
    it "flashes a notice if the bookmark doesn't save" do
      Bookmark.any_instance.stub(:save) { false }
      request
      expect(flash[:notice]).to include "There was a problem bookmarking this user"
    end
    
    it "redirects back" do
      controller.request.should_receive(:referer).and_return('/example.com/some-path')
      request
      expect(response).to redirect_to "/example.com/some-path"
    end
  end
  
  describe "DELETE 'destroy'" do
    it "destroy the bookmark" do
      bookmark = mock_model(Bookmark)
      controller.stub(:current_user) { user }
      user.bookmarks.should_receive(:find).with("1").and_return(bookmark)
      bookmark.should_receive(:destroy)
      delete :destroy, id: 1
      expect(response).to redirect_to root_path
    end
  end

end
