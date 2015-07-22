class OrderItemsController < ApplicationController
  def create
    product = Product.find_by(id: params[:product_id])
    order = current_order
    # is calling products on order a problem if it's a new order?
    previous_product = order.products.find_by(id: product.id)

    if previous_product
      previous_order_item = OrderItem.where(order_id: order.id).find_by(product_id: product.id)
      previous_order_item.quantity += (params[:order_item][:quantity]).to_i
      previous_order_item.save
      flash[:success] = "You have added #{params[:order_item][:quantity]} x #{product.name} to your cart."
    else
      order_item = order.order_items.new(quantity: params[:order_item][:quantity], 
        product_id: product.id)
      order_item.save
      flash[:success] = "You have added #{order_item.quantity} x #{product.name} to your cart."
    end

    session[:order_id] = order.id

    redirect_to product
  end

  def update
    order_item = OrderItem.find(params[:id])
    old_quantity = order_item.quantity
    order_item.update(order_item_params)
    if order_item.save
      if order_item.quantity == old_quantity
        flash[:success] = "No change was made."
      else
        flash[:success] = "Your order has been updated."
      end
      redirect_to cart_path
    else
      flash[:errors] = "There was a problem with your update."
      redirect_to cart_path
    end
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
    # raise
    # @order_items = OrderItem.where(order_id: session[:order_id])
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity)
  end
end
