require 'spec_helper'

describe PhotosController do
  context "when signed in" do
    
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
  
  describe "POST 'email'" do
    let(:bookis) { create(:bookis) }
    let(:request) { post :email, mandrill_events: [mandrill_callback(bookis)] }
    it "is successful" do
      request
      expect(response.status).to eq 201
    end
    
    it "creates a photo" do
      expect { request }.to change(Photo, :count).by(1)
    end
    
    context "when it doesn't save" do
      before { Photo.any_instance.stub(:save) { false }}
      
      it "returns a 422" do
        request
        expect(response.status).to eq 422
      end
    end
  end
end
