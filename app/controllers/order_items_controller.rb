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

  def update
    # raise
    @order_item = OrderItem.find(params[:id])
    @order_item.update(order_item_params)
    flash[:success] = "Your order has been updated."

    redirect_to cart_path
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    removed_product_name = order_item.product.name
    order_item.delete
    flash[:success] = "You removed #{removed_product_name} from your cart."

    redirect_to cart_path
  end


  def cart
    @order_items = OrderItem.where(order_id: session[:order_id])
    # order = Order.find(session[:order_id])
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end
