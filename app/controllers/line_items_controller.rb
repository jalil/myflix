class LineItemsController < ApplicationController
  before_filter :require_user

  def index
    @line_items = current_user.line_items
  end

  def create
    video = Video.find(params[:video_id])
    current_user.line_items.where(video_id: video.id,  position: current_user.line_items.count + 1).first_or_create if video
    redirect_to my_queue_path, notice: "Video Added To Your Queue"
  end

  def destroy
    item = LineItem.find(params[:id])
    item.destroy if item.user == current_user
       redirect_to my_queue_path
  end

  def update_line
   LineItem.update_queue(params[:line_items])
   redirect_to my_queue_path
   end
end
