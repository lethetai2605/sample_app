require "application_system_test_case"
require "test_helper"

class UsersTest < ApplicationSystemTestCase
  def setup
    @user = User.new(name: "Example", email: "example@email.com",
                     password: "12345tai", password_confirmation: "12345tai")
  end
  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end
  test "create micropost" do
    @user.save
    @user.microposts.create!(content: "Test Post")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end
end
