class NotificationBroadcastJob < ApplicationJob
  # frozen_string_literal: true
  queue_as :default

  def perform(micropost, destroy = false)
    ActionCable.server.broadcast 'notification_channel',
                                 notification: render_notification(micropost),
                                 micropost: micropost, destroy: destroy,
                                 poster: micropost.user.id
  end

  private

  def render_notification(micropost)
    ApplicationController.renderer.render(partial: 'shared/notification', locals: { micropost: micropost })
  end
end
