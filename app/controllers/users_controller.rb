 class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
    AppMailer.welcome_email(@user).deliver
		redirect_to login_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
    @reviews = @user.reviews
    @line_items = @user.line_items
	end
end
