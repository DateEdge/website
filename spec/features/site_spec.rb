require 'spec_helper'

describe "tests user experience", js: true do
  let!(:bookis) { create(:bookis, bio: "This is my bio", visible: true, settings: {featured: true}) }
  let!(:shane)  { create(:shane, featured: true, visible: true)  }
  
  it "does views users, crushes, bookmarks, and stuff" do
    visit "/"
    expect(page).to have_content "Date Edge"
    first(:link, "Bookis").click
    expect(page).to have_content "This is my bio"
  end
  
  context "when logged in" do
    it "does everything" do
      visit "/"
      first(:link, "Twitter").click
      fill_in('Email', :with => 'dale@example.com')
      select("January", from: "user_birthday_2i")
      select("1", from: "user_birthday_3i")
      select("1986", from: "user_birthday_1i")
      check('I agree to the terms')
      click_button("Submit")
      click_link("No Thanks")
      visit("/people")
      first(:link, "veganstraightedge").click
      page.find('.message').click
      expect(page).to have_content "New Conversation"
      fill_in("Body", with: "# Hello")
      page.save_screenshot("#{Rails.root}/tmp/spec/screenshot.png")
      expect(page.html).to include "<h1>Hello</h1>"
    end
  end
end