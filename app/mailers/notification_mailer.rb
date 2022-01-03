class NotificationMailer < ApplicationMailer
  # frozen_string_literal: true
  def new_notification(reaction)
    @reaction = reaction
    mail(to: reaction.micropost.user.email, subject: 'You got a new notification!')
  end
end
