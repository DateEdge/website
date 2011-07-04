require 'spec_helper'

describe User do
  before do
    DatabaseCleaner.clean
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

  it "should be able to a have label" do
    Label.create!(:name => "straightedge")

    @user.label = Label.first
    @user.save!

    @user.label.name.should == "straightedge"
  end

  it "should be able to have desired labels" do
    %w(straightedge drug-free).each do |label|
      @user.desired_labels.create!(:name => label)
    end

    @user.desired_labels.should == Label.all
  end

  describe "merge!" do
    before(:each) do
      sxe    = Label.create(:name => "sXe")
      @crunk = Label.create(:name => 'crunk')

      @user.providers << Provider.create(:name => "twitter", :uid => '123')
      @user.desired_labels << sxe

      @merging_user = User.create(:username => "Becker", :bio => "This should merge into the old user", :name => "SB", :email => "test@example.com", :birthday => 15.years.ago)
      @merging_user.providers << Provider.create(:name => "fb", :uid => '456')
      @merging_user.desired_labels << [sxe, @crunk]

      @user.merge! @merging_user
    end

    it "Should add crunk to the og user" do
      @user.desired_labels.should include @crunk
    end
  end
end
