# Reply
class Reply < ApplicationRecord
  # frozen_string_literal: true
  attr_accessor :destroy_notify
  after_commit {
    NotificationBroadcastJob.perform_later(micropost, destroy_notify)
  }
  def destroy_notification
    self.destroy_notify = true
  end
  belongs_to :user
  belongs_to :micropost

  default_scope -> { order(created_at: :asc) }
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
