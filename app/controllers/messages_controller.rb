class MessagesController < ApplicationController
  # frozen_string_literal: true
  def create
    @message = Message.new(message_params)
    @message.image.attach(params[:message][:image])
    @message.document.attach(params[:message][:document])
    if @message.save
      flash[:success] = 'Send message successfully'
    else
      flash[:danger] = 'Send message fail'
    end
  end

  private

  def message_params
    params.require(:message).permit(:sender_id, :receiver_id, :content, :image, :document)
  end
end
