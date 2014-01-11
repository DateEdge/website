require 'spec_helper'

describe User do
  let(:user)   { create(:user)  }
  let(:bookis) { create(:bookis) }
  let(:shane)  { create(:shane)  }
  
  it "should calculate the age correctly" do
    user.age.should == 22
  end
  
  it "trims whitespace on save" do
    user.update(me_gender: " with whitespace  ")
    expect(user.reload.me_gender).to eq "with whitespace"
  end
  
  it "has an auth token" do
    expect(user.auth_token).to be_present
  end
  
  it "sets the canonical username" do
    expect(bookis.canonical_username).to eq "bookis"
  end
  
  it "should know if your birthday happened yet" do
    user.birthday = 728.days.ago
    user.age.should == 1
  end

  it "should not update the user" do
    user.username = nil
    user.save
    expect(user.errors[:username]).to include "can't be blank"
  end
  
  it "username can't have spaces" do
    user.username = "Bookis with spaces"
    user.valid?
    expect(user.errors[:username]).to include "can only contain standard characters"
  end

  it "should be able to a have label" do
    Label.create!(name: "straightedge")

    user.label = Label.first
    user.save!

    user.label.name.should == "straightedge"
  end

  it "should be able to have desired labels" do
    %w(straightedge drug-free).each do |label|
      user.desired_labels.create!(name: label)
    end

    user.desired_labels.map(&:id).sort.should eq Label.all.map(&:id).sort
  end
  
  describe "age group" do
    it "is adult if 18 or older" do
      user.birthday = 18.years.ago.to_date
      expect(user.age_group).to eq :adult
    end
    it "is kid if 17 or younger" do
      user.birthday = (18.years.ago.end_of_day + 1.second).to_date
      expect(user.age_group).to eq :kid
    end
  end

  describe "merge!" do
    before(:each) do
      sxe    = Label.create(name: "sXe")
      @crunk = Label.create(name: 'crunk')

      user.providers << Provider.create(name: "twitter", uid: '123')
      user.desired_labels << sxe

      @merging_user = User.create(username: "Becker",
                                  bio:      "This should merge into the old user",
                                  name:     "SB",
                                  email:    "test@example.com",
                                  birthday: 15.years.ago)
      @merging_user.providers << Provider.create(name: "fb", uid: '456')
      @merging_user.desired_labels << [sxe, @crunk]

      user.merge! @merging_user
    end

    it "Should add crunk to the og user" do
      user.desired_labels.should include @crunk
    end
  end
  
  describe "avatars" do
    it "assigns the photo as avatar" do
      user.photos.create(remote_image_url: "http://placehold.it/1/1.png")
      expect(user.photos.first.avatar).to  be_true
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
    before { shane }
    it "it returns the username it it's available" do
      expect(User.available_username("username")).to eq "username"
    end
    
    it "doesn't error when a nil username is given" do
      expect {User.available_username(nil)}.to_not raise_error
      expect(User.available_username(nil)).to match /username.\d+/
    end
    
    it "a match return a temp user name" do
      expect(User.available_username("Veganstraightedge")).to match /username.\d+/
    end

    it "a downcase match return a temp user name" do
      expect(User.available_username("veganstraightedge")).to match /username.\d+/
    end
    
    it "a user can change usernames" do
      expect(shane.available_username('username')).to eq "username"
    end

    it "a user can have the same user name" do
      expect(shane.available_username('Shane')).to eq "Shane"
    end

    it "a user can have the same user name by downcase" do
      expect(shane.available_username('shane')).to eq "shane"
    end

    it "a user can't have a taken username" do
      expect(bookis.available_username('veganstraightedge')).to be_nil
    end
    
  end
  
  describe "merging" do
    it "can merge" do
      user2 = User.create(username: "bookis", name: "BS", email: "testbks@example.com", birthday: 15.years.ago)
      user.merge! user2
      user.reload
      expect(user.agreed_to_terms_at).to_not be_blank
    end
    
    it "doesn't error if the terms aren't agreed to" do
      user = create(:user, agreed_to_terms_at: nil)
      user2 = create(:bookis, agreed_to_terms_at: nil)
      user.merge! user2
      user.reload
      expect(user.agreed_to_terms_at).to be_nil
    end
  end
  
  describe "settings" do
    before { user.update(settings: {admin: true, birthday_public: true}) }
    it "has settings" do
      expect(user.settings).to_not be_blank
    end
    
    it "has admin?" do
      expect(user.admin?).to be_true
    end
    
    it "has featured" do
      expect(user.featured?).to be_nil
    end
    
    it "has public settings" do
      expect(user.birthday_public?).to  be_true
      expect(user.email_public?).to     be_nil
      expect(user.real_name_public?).to be_nil
    end
  end
  
  describe "visible users" do
    before { bookis; user; shane }
    it "shows all users" do
      expect(bookis.viewable_users).to include user, shane
      expect(bookis.viewable_users).to_not include bookis
    end
    
    it "doesn't show invisible users" do
      not_visible = create(:user, visible: false)
      expect(bookis.viewable_users).to_not include not_visible
    end
    
    it "doesn't show young users" do
      young_user = create(:user, birthday: 17.years.ago)
      expect(bookis.viewable_users).to_not include young_user
    end
    
    it "doesn't show blocked users" do
      bookis.blocks.create(blocked_id: user.id)
      expect(bookis.viewable_users).to_not include user
      expect(bookis.viewable_users).to include shane
    end
    
    it "doesn't show people who have blocked me" do
      bookis.blocks.create(blocked_id: user.id)
      expect(user.viewable_users).to_not include bookis
      expect(user.viewable_users).to include shane
    end
    
    it "doesn't show blocked and blocking" do
      bookis.blocks.create(blocked_id: user.id)
      user.blocks.create(blocked_id: shane.id)
      expect(user.viewable_users).to_not include bookis
      expect(user.viewable_users).to_not include shane
    end
  end
  
  describe "blocks" do
    let(:bookis) { create(:bookis) }
    let(:shane)  { create(:shane) }
    
    it "with_user for blocked" do
      create(:block, blocked_id: bookis.id, blocker_id: shane.id)
      expect(bookis.block_with_user?(shane)).to be_true
    end
  end
  
end
