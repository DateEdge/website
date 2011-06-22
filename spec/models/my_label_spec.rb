require 'spec_helper'

describe MyLabel do
  before do
    @user = User.create!(
      :provider => "twitter",
      :uid      => "641013",
      :name     => "Shane Becker",
      :username => "veganstraightedge",
      :email    => "veganstraightedge@gmail.com"
    )

    @label = Label.create!(:name => "straightedge")
  end

  it "should belong to a user and a label" do
    my_label = MyLabel.new
    my_label.user_id  = @user.id
    my_label.label_id = @label.id

    my_label.should be_valid
  end

  it "should be invalid without a user id" do
    my_label = MyLabel.new
    my_label.label_id = @label.id

    my_label.should be_invalid
  end

  it "should be invalid without a label id" do
    my_label = MyLabel.new
    my_label.user_id  = @user.id

    my_label.should be_invalid
  end
end
