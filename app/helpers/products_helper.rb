module ProductsHelper
  def active_text(product)
    if product.active
      "<span class=\"label label-success\">Product is ACTIVE</span>".html_safe
    else
      "<span class=\"label label-danger\">Product is INACTIVE</span>".html_safe
    end
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
