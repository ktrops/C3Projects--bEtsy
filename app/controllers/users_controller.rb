class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :validate_user, only: [:show]

  def new
    @user = User.new(user_params[:user])
  end

# trip login so user is logged in as soon as they create the account
  def create
    @user = User.create(user_params[:user])
    if @user.save
      redirect_to login_path
      flash[:success] = "Registration successful, take your shiny new username and password for a spin"
    else
      flash.now[:errors] = "Registration invalid, please try again."
      render new_user_path
    end
  end

  def show
    @user_id = params[:id]
    @user = User.find(@user_id)
  end


  private

  # this could be added to any other controllers that also require login
  def require_login
    unless session[:user_id]
      redirect_to login_path
    end
  end

  def validate_user
    if @user.id == session[:user_id]
      render :show
    else
    redirect_to user_path(session[:user_id])
    flash.now[:errors] = "Access denied"
    end
  end

  def user_params
    params.permit(user: [:username, :email, :password, :password_confirmation])
  end
end
