# relationship
class Relationship < ApplicationRecord
  # frozen_string_literal: true
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end
