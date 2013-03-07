class AppMailer < ActionMailer::Base
  default :from=> "jalilsan@gmail.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Myflix")
  end

  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Password reset")
  end
end