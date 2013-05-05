class LineItemsController < ApplicationController
  before_filter :require_user

  def index
    @line_items = current_user.line_items.order('position ASC')
  end

  def new
    line_item = LineItem.new
  end
  def create
    queue_item = LineItem.create(user_id: session[:user_id], video_id: params[:video_id], position: current_user.queue_items.count + 1)
    if queue_item.save
      redirect_to my_queue_path
    else
      redirect_to root_path, notice: "Error adding video to your queue."
    end
  end

  def destroy
    list_item = current_user.queue_items.find(params[:id])
    list_item.destroy
    flash[:error] = "Video has been removed from your queue"

    redirect_to videos_path
  end

  def update_line
    if LineItem.update_fields(params[:line_items])
      redirect_to my_queue_path
    end
  end
end
