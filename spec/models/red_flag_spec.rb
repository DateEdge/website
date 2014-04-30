require 'spec_helper'

describe RedFlag do
  let(:red_flag) { create(:red_flag) }
  it "belongs_to a user" do
    expect(red_flag.flaggable).to be_a User
  end
  
  it "belongs_to a reporter" do
    expect(red_flag.reporter).to be_a User
  end
  
  describe "validations" do
    
    it "is valid" do
      expect(red_flag).to be_valid
    end
    
    it "has a user" do
      red_flag.flaggable_id = nil
      expect(red_flag).not_to be_valid
    end
    
    it "has a user" do
      red_flag.reporter_id = nil
      expect(red_flag).not_to be_valid
    end
    
    it "scopes by user and reporter" do
      red_flag
      expect(build(:red_flag, flaggable_id: red_flag.flaggable_id, reporter_id: red_flag.reporter_id)).not_to be_valid
    end
    
    it "can have a duplicate user id" do
      red_flag
      expect(build(:red_flag, flaggable_id: red_flag.flaggable_id, reporter_id: 0)).to be_valid
    end
    
    it "can have a duplicate reporter id" do
      red_flag
      expect(build(:red_flag, flaggable_id: 0, reporter_id: red_flag.reporter_id)).to be_valid
    end
    
    it "can have a duplicate with a different type" do
      red_flag
      expect(build(:red_flag, flaggable_id: red_flag.flaggable_id, reporter_id: red_flag.reporter_id, flaggable_type: "Photo")).to be_valid
    end

  end
end
