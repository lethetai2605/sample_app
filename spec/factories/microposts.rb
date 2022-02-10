FactoryBot.define do
  factory :micropost do
    user
    content { "test factory bot" }
    user_id { user.id }
    is_read { false }
    created_at { Time.zone.now }
  end
end
