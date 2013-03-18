class PasswordResetsController< ApplicationController


  def new
    @token = params[:token]
    redirect_to expired_token_path unless User.where(password_reset_token => @token).present?
  end
  def create
    user = User.where(password_reset_token: params[:token]).first
    if user.present?
      user.password = params[:password]
      user.password_reset_token = nil
      user.save(validate: false)
      flash[:notice]= "Password has been updated"
      redirect_to login_path
    else
      redirect_to expired_token_path
    end
  end
end
