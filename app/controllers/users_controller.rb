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
    token = params[:stripeToken]
    binding.pry;
    charge = StripeWrapper::Charge.create(:amount => 999, :card => token)

        if charge.successful?
          flash[:success] = "Thank you."

	      	if @user.save
           AppMailer.delay.welcome_email(@user)
             if @user.invitation
                @user.friendships.create(:friend_id =>@user.invitation.sender_id)
             end
		        redirect_to login_path, flash: { notice: "You have successfully signed up. Please login in." }
           else
	  	      	render 'new'
	         end
        else
          flash[:error] = charge.massage
	  	    render 'new'
         end
        else
        render 'new'
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
