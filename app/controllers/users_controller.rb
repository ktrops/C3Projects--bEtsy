class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]

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

    render :show
  end


  private

  # this could be added to any other controllers that also require login
  def require_login
    flash.now[:errors] = "Please login."
    redirect_to login_path unless session[:user_id]
  end

  def user_params
    params.permit(user: [:username, :email, :password, :password_confirmation])
  end
end
