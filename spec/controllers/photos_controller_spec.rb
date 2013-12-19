require 'spec_helper'

describe PhotosController do
  before {
    sign_in
    controller.stub(:confirm_photo_belongs_to_user) { true }
  }
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    let(:photo) { mock_model("Photo") }
    
    it "should be successful" do
      Photo.should_receive(:find).with("1").and_return(photo)
      get 'edit', id: 1
      response.should be_success
    end
  end

end
