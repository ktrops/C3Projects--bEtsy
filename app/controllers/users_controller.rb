class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]

  def new

  end

  def create

  end

  def show

  end


  private

  # this could be added to any other controllers that also require login
  def require_login
    flash.now[:errors] = "Please login."
    redirect_to login_path unless session[:user_id]
  end

end
