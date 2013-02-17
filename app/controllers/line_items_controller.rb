class LineItemsController < ApplicationController
  before_filter :require_user

  def index
    @line_items = current_user.line_items
  end

  def create
    video = Video.find(params[:video_id])
    position = 1
    line_item = current_user.line_items.new(video_id: video.id, user_id: current_user.id)
    line_item.position = current_user.line_items.count + 1
    if line_item.save
      redirect_to my_queue_path, notice: "Video Added To Your Queue"
    else
      render 'video/show'
    end
  end

 def update
   line_item = LineItem.find(params[:id])
   if @item.update_attributes(params[:line_item])
      redirect_to my_queue_path , notice: 'Queue was successfully updated.' 
    else
      redirect_to my_queue_path
  end
 end

  def destroy
    @item = LineItem.find(params[:id])
    @item.destroy
       redirect_to my_queue_path
  end

  def update_line
        TheQueue.new(params[:list_items], current_user).update!
        redirect_to my_queue_path
       end

  end
