require 'spec_helper'

describe RedFlag do
  let(:red_flag) { create(:red_flag) }
  it "belongs_to a user" do
    expect(red_flag.user).to be_a User
  end
  
  it "belongs_to a reporter" do
    expect(red_flag.reporter).to be_a User
  end
end
