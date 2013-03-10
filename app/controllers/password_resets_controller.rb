class PasswordResetsController< ApplicationController

  def create
    user = User.where(token: params[:token]).first
    if user.presence?
      user.password = params[:password]
      user.token = nil
      user.save(validate: false)
      flash[:notice]= "Password has been updated"
      redirect_to root_path
    else
      redirect_to expired_token_path
    end
  end
end
