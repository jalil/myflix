class AdminController < AuthenticatedController
  def require_admin
    flash[:error] = "You do not have access to that area."  unless current_user.admin?
    redirect_to home_path
  end
end
