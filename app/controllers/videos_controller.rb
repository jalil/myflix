class VideosController < ApplicationController
  def index
	@categories = Category.limit(6)
  end


  def show
	@video = Video.find(params[:id])
  end
  
  def search
     @videos = Video.search_by_title(params[:search_term])
  end
end
