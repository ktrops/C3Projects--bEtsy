module ApplicationHelper
  def readable_price(price)
    number_to_currency(price/100.00)
  end

  # for example: Jul 24, 2015, at 06:50pm
  def readable_date(datetime)
    datetime.strftime("%b %d, %Y, at %I:%M%P")
  end
end
