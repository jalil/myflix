class VideosController < ApplicationController

  def index
	    @categories = Category.all
  end

  def new
    @video = Video.new
  end

  def show
    	#@video = Video.find_by_token(params[:id])
    	@video = Video.find(params[:id])
    	#@video = Video.find(params[:id]).decorate
      @reviews = @video.reviews
      @review = Review.new
      #
      #average_rating = @reviews.average(:rating).to_f.round(1)
  end

  def search
      @videos = Video.search_by_title(params[:search_term])
  end
end
