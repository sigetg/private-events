class UserMailer < ApplicationMailer

  def confirmation_email
    @user = params[:user]
    @url = 'https://www.youtube.com/watch?v=Fi3AJZZregI'
    mail(to: @user.email, subject: "Your event is confirmed!")
  end
end
