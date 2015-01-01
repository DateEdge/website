require "spec_helper"

describe Notification do
  let(:message) { create(:message) }
  describe "new_message" do
    let(:mail) { Notification.new_message(message.id) }

    it "renders the headers" do
      mail.subject.should eq("You have a new message from Sen-Der")
      mail.to.should eq(["r@example.com"])
      mail.from.should eq(["us@dateedge.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match('href="http://example.com/@Sen-Der/conversation"')
    end
  end

  describe "new_crush" do
    let(:crush) {create(:crush) }
    let(:mail) { Notification.new_crush(crush.id) }

    it "renders the headers" do
      mail.subject.should eq("You were crushed on by Sen-Der")
      mail.to.should eq(["r@example.com"])
      mail.from.should eq(["us@dateedge.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match('href="http://example.com/@Sen-Der"')
      
    end
  end

end
