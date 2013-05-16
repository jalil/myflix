 class UsersController < ApplicationController

	def new
    @user = User.new
	end

	def show
		@user = User.find(params[:id])
    @reviews = @user.reviews
    @line_items = @user.line_items
	end

	def create
		@user, stripe_token, invitation_token = User.new(params[:user]), params[:stripeToken], params[:token]
    result = UserSignUp.new(@user).sign_up(stripe_token, invitation_token)
    handle_registration_result(result)
  end

  def new_with_invitation
    invitation = Invitation.where(token: params[:token]).first
    if invitation.present?
      @user = User.new(full_name: invitation.recipient_name, email: invitation.recipient_email)
      @token = params[:token]
      render :new
    else
      redirect_to expired_token_path
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      AppMailer.delay.profile_update(@user)
      flash[:notice] = "Successfully updated profile"

      redirect_to videos_url
    end
  end

  private 

  def handle_registration_result(result)
    if result.invalid_user?
      binding.pry;
      render :new
    elsif  result.successful?
      flash[:success] = "You have successfully signed in up. Please sign in."
      redirect_to login_path
    else
      flash[:error] = result.strip_error_message
      render :new
   end
  end
end
