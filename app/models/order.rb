class Order < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_many :order_items

  # Validations ----------------------------------------------------------------
  validates :status, inclusion: { in: %w(pending paid complete cancelled), 
    message: "That is not a valid order status" }
  validates :cc_number, numericality: { only_integer: true }, 
    length: { in: 15..16 }, allow_nil: true

  # Scopes ---------------------------------------------------------------------
end
