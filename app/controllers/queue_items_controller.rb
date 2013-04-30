class QueueItemsController < AuthenticatedController
  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    QueueItem.create(video: video, user: current_user)
    redirect_to my_queue_path
  end

  def destroy
    item = QueueItem.find(params[:id])
    item.destroy if item.user == current_user
    redirect_to my_queue_path
  end

  def update_queue
    TheQueue.new(params[:queue_items], current_user).update!
    redirect_to my_queue_path
  end

end
