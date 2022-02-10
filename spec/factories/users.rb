FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    name { "tai123" }
    activated { true }
    read_notification { false }
    created_at { Time.zone.now }
    activated_at { Time.zone.now }
  end
end
