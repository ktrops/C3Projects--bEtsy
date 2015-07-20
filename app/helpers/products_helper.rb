module ProductsHelper
  def active_text(product)
    product.active ? "active" : "inactive"
  end

  def rating_to_stars(rating)
    case rating
    when 1
      "★☆☆☆☆"
    when 2
      "★★☆☆☆"
    when 3
      "★★★☆☆"
    when 4
      "★★★★☆"
    when 5
      "★★★★★"
    end
  end
end
