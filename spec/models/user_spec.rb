require 'spec_helper'

describe User do
  before do
    DatabaseCleaner.clean
    @user = User.create(username: "Shane", name: "SB", email: "test@example.com", birthday: 15.years.ago, agreed_to_terms_at: Time.now)
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
    expect(@user.errors[:username]).to include "can't be blank"
  end

  it "should be able to a have label" do
    Label.create!(name: "straightedge")

    @user.label = Label.first
    @user.save!

    @user.label.name.should == "straightedge"
  end

  it "should be able to have desired labels" do
    %w(straightedge drug-free).each do |label|
      @user.desired_labels.create!(name: label)
    end

    @user.desired_labels.map(&:id).sort.should eq Label.all.map(&:id).sort
  end
  
  describe "age group" do
    it "is adult if 18 or older" do
      @user.birthday = 18.years.ago.to_date
      expect(@user.age_group).to eq :adult
    end
    it "is kid if 17 or younger" do
      @user.birthday = (18.years.ago.end_of_day + 1.second).to_date
      expect(@user.age_group).to eq :kid
    end
  end

  describe "merge!" do
    before(:each) do
      sxe    = Label.create(name: "sXe")
      @crunk = Label.create(name: 'crunk')

      @user.providers << Provider.create(name: "twitter", uid: '123')
      @user.desired_labels << sxe

      @merging_user = User.create(username: "Becker",
                                  bio:      "This should merge into the old user",
                                  name:     "SB",
                                  email:    "test@example.com",
                                  birthday: 15.years.ago)
      @merging_user.providers << Provider.create(name: "fb", uid: '456')
      @merging_user.desired_labels << [sxe, @crunk]

      @user.merge! @merging_user
    end

    it "Should add crunk to the og user" do
      @user.desired_labels.should include @crunk
    end
  end
  
  describe "avatars" do
    it "assigns the photo as avatar" do
      @user.photos.create(remote_image_url: "http://placehold.it/1/1.png")
      expect(@user.photos.first.avatar).to  be_true
    end
  end
  
  describe "auth from FB" do
    before { ImageUploader.any_instance.stub(:download!) }
    let(:user) { User.create_for_facebook(facebook_auth_response) }
    
    it "is valid" do
      expect(user.new_record?).to be_false
    end
    
    it "assigns a remote photo" do
      mock_user = mock_model("User")
      User.should_receive(:create!).and_return(mock_user)
      mock_user.stub(:photos).and_return([])
      mock_user.photos.should_receive(:create).with(remote_image_url: "http://placekitten.com/10/10?type=large", avatar: true)
      user
    end
  end
  
  describe "#available_username" do
    
    it "it returns the username it it's available" do
      expect(User.available_username("username")).to eq "username"
    end
    
    it "a match return a temp user name" do
      expect(User.available_username("Shane")).to match /username.\d+/
    end

    it "a downcase match return a temp user name" do
      expect(User.available_username("shane")).to match /username.\d+/
    end
    
    it "a user can change usernames" do
      expect(@user.available_username('username')).to eq "username"
    end

    it "a user can have the same user name" do
      expect(@user.available_username('Shane')).to eq "Shane"
    end

    it "a user can have the same user name by downcase" do
      expect(@user.available_username('shane')).to eq "shane"
    end

    it "a user can't have a taken username" do
      @user2 = User.create(username: "bookis", name: "BS", email: "testbks@example.com", birthday: 15.years.ago, agreed_to_terms_at: Time.now)
      expect(@user2.available_username('shane')).to be_nil
    end
    
  end
  
  describe "merging" do
    it "can merge" do
      @user2 = User.create(username: "bookis", name: "BS", email: "testbks@example.com", birthday: 15.years.ago)
      @user.merge! @user2
      @user.reload
      expect(@user.agreed_to_terms_at).to_not be_blank
    end
  end
end
