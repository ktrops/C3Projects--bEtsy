class ApiHelper
  # Constants ---------------------------------------------
  API_URI = "http://localhost:3001/api/v1/carriers/"

  ORIGIN = {
    city:    "Great Bend",
    state:   "KS",
    zip:     "67530",
    country: "US"
  }

  TWO_DAY         = "FedEx 2 Day"
  GROUND          = "FedEx Ground Home Delivery"
  FEDEX_STANDARD  = "FedEx Standard Overnight"
  UPS_STANDARD    = "UPS Standard"
  UPS_THREE_DAY   =  "UPS Three-Day Select"
  UPS_GROUND      = "UPS Ground"
  # ------------------------------------------------------

  def shipping_rates(destination, packages)
    get_rates(destination, packages)
    set_services

    return @rate_array
  end

  def get_rates(destination, packages)
    @rates = HTTParty.post(
      API_URI,
      headers: {
        "Content-Type" => "application/json"
      },
      body: {
        origin:      ORIGIN,
        destination: destination,
        packages:    packages
      }.to_json
    )
  end

  def set_services
    @rate_array = []

    @rates.each do |rates|
      rates.each do |rate|
        case rate["service_name"]
        when TWO_DAY
          @rate_array.push(rate)
        when FEDEX_STANDARD
          @rate_array.push(rate)
        when GROUND
          @rate_array.push(rate)
        when UPS_STANDARD
          @rate_array.push(rate)
        when UPS_THREE_DAY
          @rate_array.push(rate)
        when UPS_GROUND
          @rate_array.push(rate)
        end
      end
    end

    return @rate_array
  end

end
