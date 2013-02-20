class LineItemsController < ApplicationController
  before_filter :require_user

  def index
    @line_items = current_user.line_items
  end

  def create
    video = Video.find(params[:video_id])
    LineItem.create(video_id: video.id, user_id: current_user.id, position: current_user.line_items.count + 1)
    redirect_to my_queue_path, notice: "Video Added To Your Queue"
  end

  def destroy
    item = LineItem.find(params[:id])
    item.destroy if item.user == current_user
       redirect_to my_queue_path
  end

  def update_line
    line_items_array = params[:line_items].to_a
    LineItem.update_queue(line_items_array, current_user)
    redirect_to my_queue_path
   
      end
  end
