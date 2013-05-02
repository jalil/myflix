class InvitationsController < AuthenticatedController

  before_filter :require_user

  def new
    @invitation  = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation].merge(sender:current_user)
    if @invitation.save
      AppMailer.delay.invitation(@invitation,invite_register_url(@invitation.token))
      redirect_to new_invitation_path
    else
      render :new
    end
  end
end
