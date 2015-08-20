class ShippingApi
  SHIPPING_URI = "http://localhost:3001/shipping?"

  def calc_shipping(query)
    response = HTTParty.get(SHIPPING_URI + query)
    response.each do |a|
      unless a[2] == nil
        a[2] = a[2].to_datetime
      end
    end
    response
  end

end
