FactoryBot.define do
  factory :report do
    reported_id { 1 }
    reporter_id { 1 }
    reason { "MyText" }
  end
end
