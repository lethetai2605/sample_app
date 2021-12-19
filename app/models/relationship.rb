# relationship
class Relationship < ApplicationRecord
  # frozen_string_literal: true
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  scope :followers, ->(user_id) { where(followed_id: user_id).where('created_at > ?', 1.month.ago) }
  scope :followings, ->(user_id) { where(follower_id: user_id).where('created_at > ?', 1.month.ago) }

  FOLLOWER_ATTRIBUTES = %w[follower_name created_at].freeze
  FOLLOWING_ATTRIBUTES = %w[following_name created_at].freeze

  def follower_name
    follower.name
  end

  def following_name
    followed.name
  end
end
