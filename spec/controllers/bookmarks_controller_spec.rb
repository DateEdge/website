require 'spec_helper'

describe BookmarksController do
  let(:user)  { create(:bookis) }
  let(:shane) { create(:shane) }
  
  before { 
    user.stub(:visible) { true }
    session[:user_id] = user.id 
  }
  
  describe "POST 'create'" do
    let(:request) { post :create, username: shane.username }
    before do
      Bookmark.any_instance.stub_chain(:bookmarkee, :username) { shane.username }
    end
    it "redirects" do
      request
      expect(response).to redirect_to person_path(shane.username)
    end
    
    it "creates a bookmark" do
      expect { request }.to change(user.bookmarks, :count).by(1)
    end

    it "creates a bookmark" do
      request
      expect(flash[:notice]).to include "Bookmark added."
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
      user.bookmarks.create(bookmarkee_id: shane.id)
      delete :destroy, username: shane.username
      expect(response).to redirect_to root_path
    end
  end

end
