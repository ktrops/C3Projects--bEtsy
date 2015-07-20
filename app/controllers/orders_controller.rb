class OrdersController < ApplicationController
  # for merchants only?
  def show
    @order = Order.find(params[:id])
  end

  # def cart
  #   order = Order.find(session[:order_id])
  #   @order_items = order.order_items
  # end

  # def create
  #   Order.create
  # end

  def checkout
    order = Order.find(session[:order_id])
    @order_items = order.order_items
  end

  # def purchase
  #   order = Order.find(session[:order_id])
  #   order.update(order_params)
  #   if order.save
  #     redirect_to finalize_order_path
  #   else
  #     render purchase
  #   end
  # end

  private

  # do I need this here? will need it for :update, not for :create
  def order_params
    params.require(:order).permit(:status, :email, :cc_name, :cc_number, 
      :cc_expiration, :cc_cvv, :billing_zip, :shipped, :address1, :address2,
      :city, :state, :mailing_zip)
  end
end
