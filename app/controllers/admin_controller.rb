class AdminController < ApplicationController

  def require_admin
      if !current_user.admin
        flash[:error] = "You do not have access to that area."
        redirect_to home_path
      end
  end
end
