class PasswordResetsController< ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      flash[:success] = "We have sent an email with instruction on how to reset your password."
      redirect_to login_path
    else
      flash[:error] = "Email address is not valid!"
      redirect_to :back
     end
  end

  def edit
    user = User.find_by_password_reset_token(params[:token])
    if user
      @token = params[:token]
    else
      redirect_to password_reset_url
      flash[:error] = "Invalid reset token"
    end
  end

  def update
    @user = User.find_by_password_reset_token(:params[:token])
    @user.update_attributes(password: password[:password])
    redirect_to login_path flash[:success] = "Password has been reset!" 
  end
end
