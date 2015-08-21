class OrderItemsController < ApplicationController
  def create
    order = current_order
    product = Product.find_by(id: params[:product_id])

    previous_product = order.products.find_by(id: product.id)

    if previous_product
      previous_order_item = order.order_items.find_by(product_id: previous_product.id)
      previous_quantity = previous_order_item.quantity
      previous_order_item.quantity += (params[:order_item][:quantity]).to_i
      if previous_order_item.quantity > previous_product.stock
        previous_order_item.quantity = previous_product.stock
        flash[:errors] = "There are only #{previous_product.stock} x #{previous_product.name} available for sale."
      end
      previous_order_item.save
      flash[:success] = "You have added #{previous_order_item.quantity - previous_quantity} x #{product.name} to your cart."
    else # new product
      order_item = order.order_items.new(order_item_params)
      order_item.product = product
      if params[:order_item][:quantity].to_i > order_item.product.stock
        flash[:errors] = "You can't buy that many. Stock available for this item: #{order_item.product.stock}."
        redirect_to product and return
      end
      order_item.save
      if order_item.save
        flash[:success] = "You have added #{order_item.quantity} x #{product.name} to your cart."
      else
        flash[:errors] = "There was a problem with adding this item to your cart."
      end
    end

    redirect_to product
  end

  def update
    order_item = OrderItem.find(params[:id])
    old_quantity = order_item.quantity
    if params[:order_item][:quantity].to_i > order_item.product.stock
      flash[:errors] = "You can't buy that many. Stock available for this item: #{order_item.product.stock}."
      redirect_to cart_path and return
    end
    order_item.update(order_item_params)
    order_item.save
    if order_item.save
      if order_item.quantity == old_quantity
        flash[:success] = "No change was made."
      else
        flash[:success] = "Your order has been updated."
      end
    else
      flash[:errors] = "There was a problem with your update."
    end
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
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :item_total)
  end
end
