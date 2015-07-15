class OrdersController < ApplicationController
  def show
  end

  def new
  end

  def create
    order = Order.create(order_params)
    if order.save
      # redirect_to ?? will this go anywhere? when is an order created
    end
  end

  private

  # do I need this here? will need it for :update, not for :create
  def order_params
    params.require(:order).permit(:status, :email, :cc_name, :cc_number, 
      :cc_expiration, :cc_cvv, :billing_zip, :shipped, :address1, :address2,
      :city, :state, :mailing_zip)
  end
end
