module ApplicationHelper
  def readable_price(price)
    number_to_currency(price/100.0)
  end

  def readable_date(datetime)
    datetime.strftime("%b %d, %Y, at %I:%M%P")
  end
end
