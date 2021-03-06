class ReviewsController < ApplicationController

  def create
     video = Video.find(params[:video_id])
     review = video.reviews.build(params[:review].merge!(user_id: current_user.id))

     if review.save
       redirect_to video
     else
       flash[:error] = "Please input some content"
      render 'videos/show'
      end
  end
end
