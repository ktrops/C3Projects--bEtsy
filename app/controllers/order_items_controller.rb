class OrderItemsController < ApplicationController
  def create
    product = Product.find_by(id: params[:product_id])
    order = current_order
    previous_product = order.products.find_by(id: product.id)

    if previous_product
      previous_order_item = OrderItem.where(order_id: order.id).find_by(product_id: product.id)
      previous_order_item.quantity += params[:order_item][:quantity]
      previous_order_item.save
    else
      order_item = order.order_items.new(quantity: params[:order_item][:quantity], 
        product_id: product.id)
      order_item.save
    end

    flash[:success] = "You have added #{order_item.quantity} x #{product.name} to your cart."
    session[:order_id] = order.id

    redirect_to product
  end

  def update
    order_item = OrderItem.find(params[:id])
    order_item.update(order_item_params)
    flash[:success] = "Your order has been updated."

    redirect_to cart_path
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    removed_product_name = order_item.product.name
    order_item.delete
    flash[:notice] = "You removed #{removed_product_name} from your cart."

    redirect_to cart_path
  end


  def cart
    @order = Order.find_by(id: session[:order_id])
    @order_items = OrderItem.where(order_id: session[:order_id])
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end
