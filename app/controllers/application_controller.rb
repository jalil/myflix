class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?


  def current_user
  	session[:user]
#    User.find(session[:user])
  end

  def logged_in?
  	 !!current_user 
  	
  end

  def require_user
  	if !logged_in?
  		 redirect_to root_path, notice: "You must be logged in for this action"

 		end
	end
end
