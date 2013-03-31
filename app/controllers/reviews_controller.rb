class ReviewsController < ApplicationController
  before_filter :require_user, only: [:create]
  def create
     video = Video.find(params[:video_id])
     binding.pry
     review = video.reviews.build(params[:review].merge!(user_id: current_user.id))

     if review.save
       redirect_to video
     else
      render 'videos/show'
      end
  end
end
