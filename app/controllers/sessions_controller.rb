class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user
      log_in @user

      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    log_out unless current_user.nil?

    redirect_to root_path
  end
end
