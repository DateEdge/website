require 'spec_helper'

describe "admin", js: true do
  let!(:bookis) { create(:bookis, bio: "This is my bio", visible: true, settings: {featured: true}, admin: true) }
  let!(:shane)  { create(:shane, featured: true, visible: true)  }

  it "manages things" do
    ApplicationController.any_instance.stub(:current_user).and_return(bookis)
    visit "/admin"
    expect(current_path).to eq "/admin"
    visit person_path(shane)
    page.find("#flags a.btn-block").click
    expect(page).to have_selector ".alert"
    expect(page).to have_selector ".unblock"
    visit "/admin"
    click_link "Red Flags →"
    # TODO FIXME
    # page.find(".red-flag a").click
    # click_button "Delete User"
    # expect(current_path).to eq "/admin"
    # visit person_path(shane)
    # expect(current_path).to eq "/"
  end
end
