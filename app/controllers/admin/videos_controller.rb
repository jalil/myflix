class Admin::VideosController < AdminController

  def new
    @video = Video.new
  end

  def index
    @videos =  Video.all
    @categories = Category.all
  end

  def create
   @video = Video.new(params[:video])
   @video.save
   redirect_to admin_videos_url
  end

  def edit
    video = Video.find(params[:id])
  end

  def update
      video  = Video.find(params[:id])
      video.update_attributes(params[:video])
  end
end
