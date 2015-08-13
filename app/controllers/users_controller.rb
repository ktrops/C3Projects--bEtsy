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

      redirect_to register_path
    end
  end

  def show
    sales_quantity
    @total_sales = total_sales_for_current_user
    @recent_sales = @user.recent_sales

    render :show
  end

  def edit
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

  # this calculates total sales for the current_user, which is set in the sessions[:user_id]
  def total_sales_for_current_user
    total_sales = 0
    @user.order_items.each do |order_item|
      if order_item.order.status != "cancelled"
        total_sales += order_item.quantity * order_item.product.price
      end
    end
    total_sales/100
  end

  def sales_quantity
    @quantity_sold = 0
    sales_array = @user.order_items
    sales_array.each do |sale|
      if sale.order.status != "cancelled"
        @quantity_sold += sale.quantity
      end
    end
  end
end # end of class
