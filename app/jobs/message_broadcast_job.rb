class MessageBroadcastJob < ApplicationJob
  # frozen_string_literal: true
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chat_room_#{message.receiver.id}_channel",
                                 received_message: render_message(message),
                                 message: message, chat_window: render_chat_window(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/receiver', locals: { message: message })
  end

  def render_chat_window(message)
    data = {
      messages: Message.pair_messages(message.sender.id, message.receiver.id),
      receiver_id: message.sender.id,
      sender_id: message.receiver.id,
      current_user: message.receiver
    }
    ApplicationController.renderer.render(partial: 'messages/chat_form',
                                          locals: data)
  end
end
