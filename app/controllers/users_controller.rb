class UsersController < ApplicationController
  before_action :logged_in?, only: [:show]

  def show
    @user = User.find(@current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user

      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def logged_in?
    redirect_to login_path if current_user.nil?
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
