class Order < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_many :order_items
  has_many :products, through: :order_items

  # Validations ----------------------------------------------------------------
  validates :status, inclusion: { in: %w(pending paid complete cancelled), 
    message: "That is not a valid order status" }
  validates :cc_number, numericality: { only_integer: true }, 
    length: { in: 15..16 }, on: :update
  validates :address1, :city, :state, presence: true, on: :update

  validates :cc_cvv, numericality: { only_integer: true }, length: { is: 3 }, on: :update
  validates :billing_zip, numericality: { only_integer: true }, length: { is: 5 }, on: :update
  validates :mailing_zip, numericality: { only_integer: true }, length: { is: 5 }, on: :update

  # Scopes ---------------------------------------------------------------------
  def total
    order_items.inject(0) { |sum, item| sum += (item.product.price * item.quantity) }
  end
end
