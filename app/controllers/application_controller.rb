class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login
  before_action :set_gon

  private

  def require_login
    unless current_user
      redirect_to login_url
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_gon
    gon.push({
      :app_name => "carpet"
    })
  end

  helper_method :current_user
end
