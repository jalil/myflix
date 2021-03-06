class RelationshipsController < ApplicationController
  before_filter :require_user

  def index
    @relationships = current_user.following_relationships
  end

  def destroy
    relationship = current_user.following_relationships.where(id: params[:id]).first
    relationship.destroy if relationship

    redirect_to people_path
  end

  def create
    influencer = User.find(params[:id])
    current_user.follow(influencer)

    redirect_to people_path
  end
end
