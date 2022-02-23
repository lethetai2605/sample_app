class ReportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.block_notification.subject
  #
  def block_notification(user) 
    @user = user
    mail(to: user.email, subject: 'Your account is locked for 15 days for violating our standards!')
  end
end
