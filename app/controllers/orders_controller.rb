class OrdersController < ApplicationController
  before_action :authenticate_user, only: [:show, :fulfillment]
  before_action :belongs_to_user, only: [:show]
  before_action :correct_merchant, only: [:fulfillment]

  def show
    @order = Order.find(params[:id])
    @user_items = @current_user.order_items
    @total_sales = total_sales(@order, @user_items)
  end

  def checkout
    @order = Order.find(session[:order_id])
    @order_items = @order.order_items
  end

  def finalize

    @order = Order.find(session[:order_id])
    @order_items = @order.order_items
    @order_items.each do |order_item|
      order_item.set_item_total
    end
    @order.status = "paid"
      # binding.pry
    if @order.update(order_params)
      Product.update_stock!(@order)
      flash[:confirmed_order_id] = @order.id
      # how to persist page if refreshed?
      session[:order_id] = nil

      redirect_to confirmation_path
    else
      flash.now[:errors] = "Your order could not be completed. See below for errors."

      render :checkout
    end
  end

  def confirmation
    flash.keep
    @order = Order.find(flash[:confirmed_order_id])
    # use the below line for debugging (to avoid losing the flash[:confirmed_order_id])
    # @order = Order.find(12)
  end

  def cancel
    @order = Order.find(flash[:confirmed_order_id])
    @order.status = "cancelled"
    @order.save

    redirect_to root_path
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

  def merchant
    @products_array = []
    @merchants = User.all
    if params[:user].empty?
      redirect_to products_path
    else
      @merchant = User.find(params[:user])
      @merchant_products = @merchant.products

      render :index
    end
  end

  def filter_status
    if params[:status].empty?
      redirect_to order_fulfillment_path
    else
      # setup for fulfillment action
      # page still needs @order_items != nil
      # even though not rendering it
      @user = User.find(params[:id])
      @order_items = @user.order_items
      # orders displayed after filter
      @filtered_order_items = OrderItem.joins(:order, :product).where(orders: { status: params[:status] }, products: { user_id: @user.id })

      render :fulfillment
    end
  end

  private

  # ensures merchant signed in can only see their own user pages
  def correct_merchant
    if request.path.include?(session[:user_id].to_s) == false
      redirect_to user_path(@user.id)
    end
  end

  def belongs_to_user
    @order = Order.find(params[:id])
    @order.products.each do |x|
      if x.user_id == @current_user.id
        return
      end
    end

    redirect_to order_fulfillment_path(@user.id)
  end

  def order_params
    params.require(:order).permit(:status, :email, :cc_name, :cc_number,
      :cc_expiration, :cc_cvv, :billing_zip, :shipped, :address1, :address2,
      :city, :state, :mailing_zip, :mailing_name)
  end

  def total_sales(order, user_items)
    total_sales = 0
    order.order_items.each do |order_item|
      if user_items.include?(order_item)
        if order.status == "pending"
          total_sales += order_item.quantity * order_item.product.price
        else
          total_sales += order_item.item_total
        end
      end
    end
    total_sales/100
  end
end
