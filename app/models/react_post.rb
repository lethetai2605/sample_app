# ReactPost
class ReactPost < ApplicationRecord
  # frozen_string_literal: true
  attr_accessor :destroy_notify

  belongs_to :micropost
  belongs_to :reaction
  belongs_to :user

  after_create :perform_destroy_notify
  after_destroy :destroy_notification, :perform_destroy_notify

  def perform_destroy_notify
    NotificationBroadcastJob.perform_later(micropost, destroy_notify)
  end

  def destroy_notification
    self.destroy_notify = true
  end
end
