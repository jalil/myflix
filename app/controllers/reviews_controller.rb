class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @video = Video.find(params[:video_id])
    @review = Review.new
  end

  def create
     @video =Video.find(params[:video_id])
     @review = @video.reviews.create(params[:comment])
     @review.user = current_user
      if @review.save
        flash[:notice] = "Review was saved"
        redirect_to video_path(@video)
      else
        render 'video/show'
      end
  end
end
