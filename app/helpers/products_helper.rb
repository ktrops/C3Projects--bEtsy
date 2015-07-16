module ProductsHelper
  def active_text(product)
    product.active ? "active" : "inactive"
  end
end
