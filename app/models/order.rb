class Order < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_many :order_items

  # Validations ----------------------------------------------------------------
  validates :status, inclusion: { in: %w(pending paid complete cancelled), 
    message: "That is not a valid order status" }

  # Scopes ---------------------------------------------------------------------
end
