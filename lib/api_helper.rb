class ApiHelper
  # Constants ---------------------------------------------
  if Rails.env.development?
    API_URI_INDEX = "http://localhost:3001/api/v1/carriers/"
    API_URI_LOG   = "http://localhost:3001/api/v1/logs/"
  else
    API_URI_INDEX = "https://shipleys.herokuapp.com/api/v1/carriers/"
    API_URI_LOG   = "https://shipleys.herokuapp.com/api/v1/logs/"
  end

  APP_NAME = "Secrets R Us"

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
      API_URI_INDEX,
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

  def send_log(order_id, service_name)
    HTTParty.post(
      API_URI_LOG,
      headers: {
        "Content-Type" => "application/json"
      },
      body: {
        order_id: order_id,
        carrier_service: service_name,
        app_name: APP_NAME
      }.to_json
    )

  end

end
