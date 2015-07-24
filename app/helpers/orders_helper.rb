module OrdersHelper
  def frendly_shipped_status(shipped_status)
    shipped_status ? "Shipped" : "Not Shipped"
  end

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

  def pending_order_revenue
    revenue = 0
    @order_items.each do |order_item|
      if order_item.order.status == "pending"
        revenue += order_item.item_total
      end
    end
    return revenue
  end

  def paid_order_revenue
    revenue = 0
    @order_items.each do |order_item|
      if order_item.order.status == "paid"
        revenue += order_item.item_total
      end
    end
    return revenue
  end

  def complete_order_revenue
    revenue = 0
    @order_items.each do |order_item|
      if order_item.order.status == "complete"
        revenue += order_item.item_total
      end
    end
    return revenue
  end

  def cancelled_order_revenue
    revenue = 0
    @order_items.each do |order_item|
      if order_item.order.status == "cancelled"
        revenue += order_item.item_total
      end
    end
    return revenue
  end
end
