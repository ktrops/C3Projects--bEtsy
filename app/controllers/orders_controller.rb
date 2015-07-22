class OrdersController < ApplicationController
  before_action :authenticate_user, only: [:show, :fulfillment]

  def show
    @order = Order.find(params[:id])
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
    raise
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
    @user = User.find(params[:id])
    @order_items = @user.order_items

    order_ids = []
    @order_items.each do |order_item|
      order_ids << order_item.order_id
    end

    @orders = Order.where(:id => order_ids )
    # @completed_orders = @orders.where(status: "completed")

  end


  private

  def order_params
    params.require(:order).permit(:status, :email, :cc_name, :cc_number,
      :cc_expiration, :cc_cvv, :billing_zip, :shipped, :address1, :address2,
      :city, :state, :mailing_zip, :mailing_name)
  end

  def total_sales
    @total_sales = 0
    @order.order_items.each do |x|
    @total_sales += x.quantity * x.product.price
    end
  @total_sales = @total_sales/100
  end
end
