class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :prepare_for_mobile

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

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

  helper_method :mobile_device?

end
