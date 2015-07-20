class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]

  def new
    @user = User.new(user_params[:user])
  end

# trip login so user is logged in as soon as they create the account
  def create
    @user = User.create(user_params[:user])
    if @user.save
      flash[:success] = "Registration successful, take your shiny new username and password for a spin"
      redirect_to login_path
    else
      flash.now[:errors] = "Registration invalid, please try again."
      render new_user_path
    end
  end

  def show
    @user_id = params[:id]
    @user = User.find(@user_id)
    sales_quantity
    @message = random_welcome

    render :show
  end

  def profile
    @user_id = params[:id]
    @user = User.find(@user_id)
  end

  def edit

    render :edit
  end

  def update
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

  def random_welcome
    welcomes = ["Bienvenidos ", "We missed you ", "Looking pretty fly ", "Greetings ", "Take me to your leader ", "Good day ", "Happy to see you ", "Hey it's my favorite vendor "]
    welcomes.sample
  end

  def total_sales
# waiting on orders to complete this method :)

  end

  def sales_quantity
    @quantity_sold = 0
    sales_array = @user.order_items
    sales_array.each do |x|
      @quantity_sold += x.quantity
    end
  end


end # end of class
