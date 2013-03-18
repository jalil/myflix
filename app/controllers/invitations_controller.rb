class InvitationsController < ApplicationController
before_filter :require_user
  def new
    @invitation  = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user

    if @invitation.save
      AppMailer.invitation(@invitation,invite_register_url(@invitation.token)).deliver
      flash[:notice] = "Invitation was sent"
      redirect_to videos_path
    end

  end
end
