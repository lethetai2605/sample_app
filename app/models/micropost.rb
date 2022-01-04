# Micropost
class Micropost < ApplicationRecord
  # frozen_string_literal: true

  MICROPOST_ATTRIBUTES = %w[content created_at].freeze
  scope :recent_posts, ->(user_id) { where(user_id: user_id).where('created_at > ?', 1.month.ago) }
  has_many :react_posts, dependent: :destroy
  has_many :replies, dependent: :destroy

  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  def user_already_liked?(user)
    react_posts.where(user_id: user.id).exists?
  end

  scope :all_notification, ->(user_id) {
    where(user_id: user_id)
  }
  scope :all_unread_replies, ->(user_id) {
    left_joins(:replies).where(user_id: user_id, is_read: false).where.not(replies: { id: nil }).where.not(replies: { user_id: user_id })
  }
  scope :all_unread_reactions, ->(user_id) {
    left_joins(:react_posts).where(user_id: user_id, is_read: false).where.not(react_posts: { id: nil }).where.not(react_posts: { user_id: user_id })
  }
end
