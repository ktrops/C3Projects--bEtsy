class ShippingApi
  SHIPPING_URI = "http://localhost:3001/shipping?"

  def calc_shipping(query)
    response = HTTParty.get(SHIPPING_URI + query)
  end

end
