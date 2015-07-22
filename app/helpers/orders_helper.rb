module OrdersHelper
  def frendly_shipped_status(shipped_status)
    shipped_status ? "Shipped" : "Not Shipped"
  end
end
