class OrderItemsController < ApplicationController
    def create
    @product = Product.find(params[:product_id])
    @order = current_order

    @order_item = @order.order_items.new(quantity: params[:order_item][:quantity], 
      product_id: @product.id)
    @order_item.save
    session[:order_id] = @order.id

    redirect_to @product
  end
end
