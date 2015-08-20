class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true }

  def set_item_total
    self.item_total = product.price * quantity
    self.save
  end

end
