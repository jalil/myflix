class PasswordResetsController < ApplicationController

  def new
    @token = params[:token]
    redirect_to expired_token_path unless User.where(token: @token).present?
  end

  def create
    user = User.where(token: params[:token]).first
    if user.present?
      user.password = params[:password]
      user.token = nil
      user.save(validate: false)
      flash[:success] = 'Password has been reset!'
      redirect_to sign_in_path
    else
      redirect_to expired_token_path
    end
  end
end
