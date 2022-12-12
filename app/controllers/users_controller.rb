# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  login           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UsersController < ApplicationController
  def index
    @page_name = "System Users"
    @users = User.all.order(:name)
  end

  def new
    @page_name = "Add New User"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User Successfully Created"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "User Updated Successfully"
    else
      render :edit
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :login, :password, :password_confirmation)
  end

end
