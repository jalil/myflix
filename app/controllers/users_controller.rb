 class UsersController < ApplicationController
   before_filter :require_user, only: [:show]

	def new
    @user = User.new
	end

	def create
		@user = User.create(params[:user])
    token = params[:stripeToken]

    if @user.valid?
      response = StripeWrapper::Charge.create(:amount => 999, :card => token, description: @user.email)

        if response.successful?
           @user.save
           flash[:success] = "Thank you."
           flash[:error] = "You have succefully signed up. Please sign in" 
           AppMailer.welcome_email(@user).deliver
           handle_invitation(invitation) if invitation
	     redirect_to login_path
         else
            flash[:error] = response.error_massage
	    render 'new'
         end
      else
        render 'new'
      end
    end

  def new_with_invitation
    invitation = Invitation.where(token: params[:token]).first
    if invitation.present?
      @user = User.new(full_name: invitation.recipient_name, email: invitation.recipient_email)
      @token = params[:token]
      render :new
    else
      redirect_to expired_token_path
    end
  end

	def show
		@user = User.find(params[:id])
    @reviews = @user.reviews
    @line_items = @user.line_items
	end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      AppMailer.delay.profile_update(@user)
      flash[:notice] = "Successfully updated profile"

      redirect_to videos_url
    end
  end

  private 

  def handle_invitation(invitation)
    @user.follow(invitation.sender)
    invitation.sender.follow(@user)
    invitation.update_attribute(:token, nil)
  end
end
