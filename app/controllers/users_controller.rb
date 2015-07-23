class UsersController < ApplicationController

  before_action :authenticate_user, except: [:new, :create]
  before_action :save_login_state, only: [:new]

  def new
    @new_user = User.new(user_params[:user])
  end

# trip login so user is logged in as soon as they create the account
  def create
    @user = User.create(user_params[:user])
    if @user.save
      flash[:success] = "Registration successful, take your shiny new username and password for a spin"
      redirect_to login_path
    else
      flash.now[:errors] = "Registration invalid, please try again."
      redirect_to new_user_path
    end
  end

  def show
    sales_quantity
    total_sales
    recent_sales
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

  def user_params
    params.permit(user: [:username, :email, :password, :password_confirmation])
  end

  def random_welcome
    welcomes = ["¡Bienvenidos ", "We missed you ", "Greetings ", "Take me to your leader ", "Good day ", "Happy to see you ", "Hey it's my favorite vendor ", "Hey boo, glad to see your face again ", "Oh hai there ", "Ni hao ", "Is that a new outfit? looking good "]
    welcomes.sample
  end

  def total_sales
    @total_sales = 0
    @user.order_items.each do |x|
      if x.order.status != "cancelled" && x.order.status != "pending"
        @total_sales += x.quantity * x.product.price
      end
    end
    @total_sales=@total_sales/100
  end

  def sales_quantity
    @quantity_sold = 0
    sales_array = @user.order_items 
    sales_array.each do |x|
      if x.order.status != "cancelled" && x.order.status != "pending"
        @quantity_sold += x.quantity
      end
    end
  end

  def recent_sales
    @recent_sales = @current_user.order_items('created_at DESC').limit(5)
  end

end # end of class
