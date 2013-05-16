 class UserSignUp
   attr_reader :user


  def initialize(user)
    @user = user
  end

  def sign_up(stripe_token, invitation_token)
    if user.valid?
      response = StripeWrapper::Charge.create(:amount => 999, currency: 'usd', :card => stripe_token, description: user.email)

        if response.successful?
           user.save
           Payment.create(user: user, amount: response.amount, reference_id: response.reference_id)
           AppMailer.welcome_email(user).deliver
           invitation = Invitation.where(token: invitation_token).first
           handle_invitation(invitation) if invitation
           UserSignUpResult.new(true, false, nil)
        else
           UserSignUpResult.new(true, false, response.error_message)
        end
      else
          UserSignUpResult.new(true, false, nil)
      end
  end



  def handle_invitation(invitation)
    user.follow(invitation.sender)
    invitation.sender.follow(user)
    invitation.update_attribute(:token, nil)
  end
end

class UserSignUpResult < Struct.new(:successful, :invalid_user, :stripe_error_message)
   def invalid_user?
     self[:invalid_user]
   end
   
   def successful?
     self[:successful]
   end
 end
