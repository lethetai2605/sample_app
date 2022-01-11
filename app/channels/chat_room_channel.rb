class ChatRoomChannel < ApplicationCable::Channel
  # frozen_string_literal: true
  def subscribed
    stream_from "chat_room_#{current_user.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
