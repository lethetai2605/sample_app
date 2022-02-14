require "rails_helper"

RSpec.describe "micropost", type: :system do
  before do
    driven_by(:rack_test)
  end
  it "posting" do
    visit "/login"
    fill_in "Email", with: "admin@admin.com"
    fill_in "Password",	with: "123"
    click_button "Log in"
    visit "/"
    fill_in "micropost[content]",	with: "test post"
    click_button "Post"
    expect(page).to have_text("Micropost created!")
  end
end
