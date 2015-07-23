class OrdersController < ApplicationController
  before_action :authenticate_user, only: [:show, :fulfillment]
  before_action :belongs_to_user, only: [:show]

  def show
    @order = Order.find(params[:id])
    @user_items = @current_user.order_items
    total_sales
  end

  def checkout
    @order = Order.find(session[:order_id])
    @order_items = @order.order_items
  end

  def finalize
    @order = Order.find(session[:order_id])
    @order_items = @order.order_items
    @order.update(order_params)
    @order.status = "paid"
    @order.save
    # didn't redirect after bad info inputted
    if @order.save
      Product.update_stock!(@order)
      flash[:confirmed_order_id] = @order.id
      # how to persist page if refreshed?
      session[:order_id] = nil

      redirect_to confirmation_path
    else
      flash.now[:errors] = "Please fill in every field to complete your order."
      render :checkout
    end
  end

  def confirmation
    flash.keep
    @order = Order.find(flash[:confirmed_order_id])
    # use the below line for debugging (to avoid losing the flash[:confirmed_order_id])
    # @order = Order.find(12)
  end

  def fulfillment
    @user = User.find(params[:id])
    @order_items = @user.order_items
    @total_revenue = @order_items.sum(:item_total)
    @filtered_order_items = nil

  end

  def mark_shipped
    @user = User.find(params[:id])
    @order = Order.find(params[:order_id])
    @order.mark_shipped!
    redirect_to order_fulfillment_path
  end

  # def merchant
  #   @products_array = []
  #   @merchants = User.all
  #   if params[:user].empty?
  #     redirect_to products_path
  #   else
  #     @merchant = User.find(params[:user])
  #     @merchant_products = @merchant.products
  #     render :index
  #   end
  # end

  def filter_status
    # setup for fulfillment action
    @user = User.find(params[:id])
    @order_items = @user.order_items

    # collect the Order IDs based on the user's particular OrderItems
    # disparate associations == ow
    order_ids = []
    @order_items.each do |order_item|
      order_ids << order_item.order_id
    end

    # the user's orders
    users_orders = Order.where(:id => order_ids )
    # the user's orders filtered by a status
    orders_by_a_status = users_orders.where(status: params[:order])

    # collect the Order IDs of only that status
    filtered_order_ids = []
    @order_items.each do |order_item|
      filtered_order_ids << order_item.order_id
    end

    @filtered_order_items = OrderItem.where(:order_id => filtered_order_ids)
    @total_revenue = @filtered_order_items.sum(:item_total)
    render :fulfillment
  end


  private

  def belongs_to_user
    @order = Order.find(params[:id])
    @array = []
    @order.products.each do |x|
      if x.user_id == @current_user.id
        break
      else
        redirect_to order_fulfillment_path(@user.id)
      end
    end
  end

  def order_params
    params.require(:order).permit(:status, :email, :cc_name, :cc_number,
      :cc_expiration, :cc_cvv, :billing_zip, :shipped, :address1, :address2,
      :city, :state, :mailing_zip, :mailing_name)
  end

  def total_sales
    @total_sales = 0
    @order.order_items.each do |x|
      if @user_items.include?(x) == true
        @total_sales += x.quantity * x.product.price
      end
    end
    @total_sales = @total_sales/100
  end
end
