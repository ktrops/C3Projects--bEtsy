class SessionsController < ApplicationController

  before_action :save_login_state, only: [:new]

  def create
    @user = User.find_by(username: params[:session][:username])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:order_id] = nil
      redirect_to user_path(@user.id)
    else
      flash.now[:errors] = "Login failed. Try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    redirect_to root_path
  end

  private

  def save_login_state
    if session[:user_id] && @user
      redirect_to user_path(@user.id)
      return false
    else
      return true
    end
  end

end
