class VideosController < ApplicationController
  def index
	@categories = Category.all
	@videos = Video.all
  end
end
