class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in
    if current_user.nil?
      redirect_to root_path
      flash[:danger] = "Please log in before continuing."
    end
  end

  helper_method :current_user

  helper_method :logged_in

end
