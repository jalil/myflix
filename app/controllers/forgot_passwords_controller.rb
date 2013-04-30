class ForgotPasswordsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first
    if user.present?
      UserMailer.reset_password(user).deliver
      redirect_to reset_password_confirmation_path
    else
      flash[:error] = "The email you entered is not in the system."
      redirect_to forgot_password_path
    end
  end

end
