class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @page_name = "Carpet Cleaner App Login"
  end

  def create
    user = User.find_by(login: params[:login])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid Username or Passsword!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You are now signed out!"
  end

end
