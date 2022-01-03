class NotificationsChannel < ApplicationCable::Channel
  # frozen_string_literal: true
  def subscribed
    stream_from 'notification_channel'
  end

  def unsubscribed; end
end
