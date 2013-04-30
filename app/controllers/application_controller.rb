class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_sign_in
    if !current_user
      flash[:error] = "You have to be a member to do that."
      redirect_to sign_in_path
    end
  end

  helper_method :current_user

end
