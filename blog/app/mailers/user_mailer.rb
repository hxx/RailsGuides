class UserMailer < ActionMailer::Base
  default from: "yellowstar520@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://huangxingxing.info'
    mail(to: "yellowstar520@gmail.com" , subject: 'Welcome to My Awesome Site')
  end
end
