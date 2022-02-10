require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user, name: "test123") }

  it "change name" do
    User.update(user.id, name: "123test")
    expect(user.reload.name).to eq("123test")
  end
  it "change email" do
    User.update(user.id, email: "test123@test.com")
    expect(user.reload.email).to eq("test123@test.com")
  end
end
