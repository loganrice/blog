class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_admin
    if current_user && current_user.admin
      true
    else
      flash[:notice] = 'restricted to signed in users with approved access'
      redirect_to root_path
    end
  end
end
