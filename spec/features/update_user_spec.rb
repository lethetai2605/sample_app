require "rails_helper"

RSpec.describe "update user", type: :system do
  before do
    driven_by(:rack_test)
  end
  it "change profile a user" do
    visit "/login"
    fill_in "Email", with: "admin@admin.com"
    fill_in "Password",	with: "123"
    click_button "Log in"
    click_link "Settings"
    fill_in "Name", with: "Change1"
    click_button "Save changes"
    expect(page).to have_text("Profile updated")
  end
end
