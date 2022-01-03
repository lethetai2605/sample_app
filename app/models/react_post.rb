# ReactPost
class ReactPost < ApplicationRecord
  # frozen_string_literal: true
  attr_accessor :destroy_notify
  after_create_commit {
    NotificationBroadcastJob.perform_later(micropost, destroy_notify)
  }
  after_destroy_commit {
    NotificationBroadcastJob.perform_later(micropost, destroy_notify)
  }
  def destroy_notification
    self.destroy_notify = true
  end
  belongs_to :micropost
  belongs_to :reaction
  belongs_to :user
end
