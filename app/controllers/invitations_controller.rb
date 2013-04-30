class InvitationsController < AuthenticatedController

  def new
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.new(params[:invitation].merge(inviter: current_user))
    if invitation.save
      UserMailer.delay.invite_user(invitation)
      redirect_to new_invitation_path
    else
      render :new
    end
  end
end
