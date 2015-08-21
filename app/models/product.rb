class Product < ActiveRecord::Base
  before_save :stock_0_make_inactive

  belongs_to :user
  has_many :orders, through: :order_items
  has_many :order_items
  has_many :reviews
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :stock, presence: true, numericality: { integer: true }
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  validates :length, presence: true, numericality: { greater_than: 0 }
  validates :width, presence: true, numericality: { greater_than: 0 }
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :product_categories

  def toggle_active!
    toggle!(:active)
  end

  def self.active_products(products)
    products.select {|product| product.active}
  end

  def self.front_page_list
    self.active_products(self.all.limit(10))
  end

  def stock_0_make_inactive
    if self.stock == 0
      self.active = false
    end
    return true
  end

  def self.update_stock!(order)
    order.order_items.each do |order_item|
      product = Product.find_by(id: order_item.product_id)
      product.stock -= order_item.quantity
      product.active = false if product.stock == 0
      product.save
    end
  end
end
