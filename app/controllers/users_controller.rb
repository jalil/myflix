class UsersController < ApplicationController
  before_filter :require_sign_in, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user, stripe_token, invitation_token = User.new(params[:user]), params[:stripe_token], params[:token]
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

  private

  def handle_registration_result(result)
    if result.invalid_user?
      render :new
    elsif result.successful?
      flash[:success] = "You have successfully signed up. Please sign in."
      redirect_to sign_in_path
    else
      flash[:error] = result.stripe_error_message
      render :new
    end
  end
end
