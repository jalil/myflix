class VideosController < ApplicationController
   before_filter :require_user
  def index
	    @categories = Category.all
  end

  def new
    @video = Video.new
  end

  def show
    	@video = Video.find(params[:id])
      @reviews = @video.reviews
      @review = Review.new
      @average_rating = @reviews.average(:rating).to_f.round(1)
  end

  def search
      @videos = Video.search_by_title(params[:search_term])
  end

end
