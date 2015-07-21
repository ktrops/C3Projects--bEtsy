class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :authenticated_user, except: [:new, :create]
  before_action :save_login_state, only: [:new]

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
    sales_quantity
    total_sales
    @message = random_welcome

    render :show
  end

  def edit

    render :edit
  end

  def update
    @user.update(user_params[:user])
    @user.save
    redirect_to user_path
  end

  private

  # this could be added to any other controllers that also require login
  def require_login
    redirect_to login_path unless session[:user_id]
  end

  def authenticated_user
    if session[:user_id]
      @user = User.find session[:user_id]
      return true
    else
      redirect_to user_path(login_path)
      return false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to user_path(@user.id)
      return false
    else
      return true
    end
  end

  def user_params
    params.permit(user: [:username, :email, :password, :password_confirmation])
  end

  def random_welcome
    welcomes = ["¡Bienvenidos ", "We missed you ", "Looking pretty fly ", "Greetings ", "Take me to your leader ", "Good day ", "Happy to see you ", "Hey it's my favorite vendor ", "Hey boo, glad to see your face again ", "Oh hai there "]
    welcomes.sample
  end

  def total_sales
    @total_sales = 0
    @user.order_items.each do |x|
      @total_sales += x.quantity * x.product.price
    end
  end

  def sales_quantity
    @quantity_sold = 0
    sales_array = @user.order_items
    sales_array.each do |x|
      @quantity_sold += x.quantity
    end
  end


end # end of class
