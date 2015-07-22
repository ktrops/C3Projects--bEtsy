class OrdersController < ApplicationController
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
    @order = Order.find(flash[:confirmed_order_id])
    # use the below line for debugging (to avoid losing the flash[:confirmed_order_id])
    # @order = Order.find(12)
  end

  def fulfillment
    @user = User.find(params[:id])
    @orders = @user.order_items
    @total_revenue = @orders.sum(:item_total)
    # @shipped
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
  end
end
