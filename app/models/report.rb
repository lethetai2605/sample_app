class Report < ApplicationRecord
  belongs_to :reported, class_name: "User"
  belongs_to :reporter, class_name: "User"
  validates :reported_id, presence: true
  validates :reporter_id, presence: true
end
