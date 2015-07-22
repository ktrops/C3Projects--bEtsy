module OrdersHelper
  def frendly_shipped_status(shipped_status)
    shipped_status ? "Shipped" : "Not Shipped"
  end

  # order status
  # "pending", "paid", "complete", "cancelled"

    # @user = User.find(params[:id])
    # @orders = @user.order_items

  def pending_orders
    orders = 0
    @order_items.each do |order_item|
      if order_item.order.status == "pending"
        orders += 1
      end
    end
    return orders
  end

  def paid_orders
    orders = 0
    @order_items.each do |order_item|
      if order_item.order.status == "paid"
        orders += 1
      end
    end
    return orders
  end

  def complete_orders
    orders = 0
    @order_items.each do |order_item|
      if order_item.order.status == "complete"
        orders += 1
      end
    end
    return orders
  end

  def cancelled_orders
    orders = 0
    @order_items.each do |order_item|
      if order_item.order.status == "cancelled"
        orders += 1
      end
    end
    return orders
  end

end
