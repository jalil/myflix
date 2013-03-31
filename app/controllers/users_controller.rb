 class UsersController < ApplicationController
   before_filter :require_user, only: [:show]

	def new
    if params[:invitation_token]
       if User.find_by_invitation_id(Invitation.find_by_token(params[:invitation_token]).id)
        redirect_to root_path, flash: { error: "Invitation already used." }
      else
        @user = User.new(:invitation_token => params[:invitation_token])
        @user.email = @user.invitation.recipient_email if @user.invitation
      end
    else
    	@user = User.new
	  end
	end

	def create
		@user = User.create(params[:user])
		if @user.save
      AppMailer.welcome_email(@user).deliver
      if @user.invitation
        @user.friendships.create(:friend_id =>@user.invitation.sender_id)
      end
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
  def update
		@user = current_user
    if @user.update_attributes(params[:user])
      AppMailer.delay.profile_update(@user)
      flash[:notice] = "Successfully updated profile"
      redirect_to videos_url
    end
  end
end
