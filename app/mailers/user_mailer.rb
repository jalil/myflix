class UserMailer < ActionMailer::Base

  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: 'jalil@myflix.com', subject: "Weclome to MyFlix!"
  end

  def reset_password(user)
    @user = user
    mail to: user.email, from: 'jalil@myflix.com', subject: "Reset Password"
  end

  def invite_user(invitation)
    @invitation = invitation
    mail to: invitation.recipient_email, from: 'jalil@myflix.com', subject: "Invitation to join Myflix!"
  end
end
