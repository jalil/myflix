class AuthenticatedController < ApplicationController


  def require_user
    flash[:info]= "Access reserved for members only. Please login or register first."  unless logged_in?
    redirect_to login_path
  end
end
