class ShippingApi
  
  if Rails.env == "production"
    SHIPPING_URI = "http://meta-shipping-api.herokuapp.com/shipping?"
  else
    SHIPPING_URI = "http://localhost:3001/shipping?"
  end

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
