require 'spec_helper'

describe Photo do
  describe "validations" do
    let(:photo) { Photo.create }
    it "isn't valid without an image" do
      expect(photo).to be_invalid
      expect(photo.errors[:image]).to include "can't be blank"
    end
  end
  
  describe "cleaning url" do
    let(:photo) { Photo.new(remote_image_url: "http://placekitten.com/1/1?blah") }
  end

end
