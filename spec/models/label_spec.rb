require 'spec_helper'

describe Label do
  it "should have a name" do
    label = Label.new
    label.name = "straightedge"
    label.save
    label.should be_valid
  end
  
  it "should be invalid with no name" do
    label = Label.new
    label.save
    label.should be_invalid
  end
end
