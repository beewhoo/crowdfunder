class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def require_login
    unless session[:user_id]
      not_authenticated
    end
  end

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
