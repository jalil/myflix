class SessionsController < ApplicationController

	def new
	end

	def create
		user =  User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
			redirect_to  videos_path, notice: "logged in"
			#redirect_to  current_user.admin? ? new_admin_video_path : videos_path, notice: "logged in"
		else
			flash[:error] = "Could not log you in"
			redirect_to login_url
		end
	end
		
		def destroy
			session[:user_id] = nil
			flash[:notice]= "Logged out"
			redirect_to login_path
		end

end
