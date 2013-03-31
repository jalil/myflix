class FriendshipsController < ApplicationController
before_filter :require_user
  def index
    @friendships = current_user.friends
  end
  
  def create
    @friendships = current_user.friendships.new(:friend_id =>params[:friend_id])
    if @friendships.save
      flash[:notice] = "Added friend"
      redirect_to people_url
    else
      flash[:error] = "Unable to add friend"
      redirect_to root_url
    end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to people_path
  end
end
