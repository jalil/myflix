class SessionsController < ApplicationController

	def new
	end

	def create
		user =  User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
		session[:user_id] = user.id
			redirect_to  videos_path, notice: "logged in"
		else
			flash[:error] = "Could not log you in"
			render 'new'

		end
	end
		
		def destroy
			session[:user_id] = nil
			redirect_to login_path notice: "Logged out"
		end

end
