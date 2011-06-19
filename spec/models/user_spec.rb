require 'spec_helper'

describe User do
  before do
    User.delete_all
    @user = User.create(:username => "Shane", :name => "SB", :email => "test@example.com", :birthday => 15.years.ago)
  end
  
  it "should calculate the age correctly" do
    @user.age.should == 15
  end
  
  it "should know if your birthday happened yet" do
    @user.birthday = 728.days.ago
    @user.age.should == 1
  end

  it "should not update the user" do
    @user.username = nil
    @user.save
    @user.should have(1).error
  end
  
end
