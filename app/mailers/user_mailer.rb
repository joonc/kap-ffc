class UserMailer < ActionMailer::Base
  default from: "AmyGutmann@freeforcoffee.com"

  # custom emails can be sent using the mailer as below.
  # def send_time_input_reminder(user)
  #   @user = user
  #   mail(to: @user.email, subject: "F@N - following up about times!")
  # end
end
