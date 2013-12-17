require 'spec_helper'

describe Conversation do
  let(:sender)  { User.create(username: "Shane",  name: "SB", email: "test@example.com", birthday: 25.years.ago, visible: true, agreed_to_terms_at: Time.now) }
  let(:recipient) { User.create(username: "Bookis", name: "BS", email: "bs@example.com",   birthday: 25.years.ago, visible: true, agreed_to_terms_at: Time.now) }

  let(:conversation) { Conversation.create(sender: sender, recipient: recipient) }

  it "is valid" do
    expect(conversation).to be_valid
  end

  describe "age validation" do
    it "has an error message if age inappropriate" do
      sender.update(birthday: 17.years.ago)
      expect(conversation.errors[:restricted]).to include "You can't send a message to that user"
    end
  end
end
