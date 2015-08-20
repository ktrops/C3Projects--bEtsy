class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true }

  def set_item_total
    self.item_total = product.price * quantity
    self.save
  end

  def package_sort(order_items)
    packages = {}
    order_items.each do |item|
      merchant = item.product.user
      merchant = merchant.username.to_sym
      if packages.has_key?(merchant)
        packages[merchant] << item
      else
        packages[merchant] = [item]
      end
    end
    return packages
  end
end
