class InvitationsController < ApplicationController
before_filter :require_user
  def new
    @invitation  = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      AppMailer.invitation(@invitation,invite_register_url(@invitation.token))
      flash[:notice] = "Invitation was sent"
      redirect_to videos_path
    else
      render :action =>new
    end

  end
end
