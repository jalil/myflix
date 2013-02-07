class PagesController < ApplicationController

  def front
    redirect_to home_path if current_user
  end

  def register
  end

  def sign_in
  end

end
