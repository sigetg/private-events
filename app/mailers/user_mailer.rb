
class UserMailer < ApplicationMailer

  require 'sendgrid-ruby'
  include SendGrid
  require 'json'

  def sendgrid_confirmation_email(to_email)
    from = Email.new(email: 'sigetyg@gmail.com')
    subject = 'Hello World from the Twilio SendGrid Ruby Library'
    to = Email.new(email: to_email)
    content = Content.new(type: 'text/plain', value: 'some text here')
    mail = SendGrid::Mail.new(from, subject, to, content)
    # puts JSON.pretty_generate(mail.to_json)
    puts mail.to_json
  
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

  def confirmation_email
    @user = params[:user]
    @url = 'https://www.youtube.com/watch?v=Fi3AJZZregI'
    mail(to: @user.email, subject: "Your event is confirmed!")
  end
end
