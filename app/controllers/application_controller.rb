class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  include Authentication

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_authentication
    binding.break
    unless logged_in?

      store_location
      redirect_to login_path, alert: "Please log in to continue."
    end
  end

  def store_location
    session[:return_to] = request.fullpath if request.get?
  end
end
