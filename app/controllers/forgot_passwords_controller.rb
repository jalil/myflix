class ForgotPasswordsController < ApplicationController

  def create
    user = User.where(email: params[:email]).first
    if user.present?
      AppMailer.password_reset(user).deliver
      redirect_to reset_password_confirmation_path
    else
      flash[:error] = "Invalid Email"
      redirect_to  forgot_password_path
    end
    end
end

