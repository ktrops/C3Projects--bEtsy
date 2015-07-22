class Product < ActiveRecord::Base
  before_save :stock_valid
  belongs_to :user
  has_many :orders, through: :order_items
  has_many :order_items
  has_many :reviews
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :product_categories
  def toggle_active!
    toggle!(:active)
  end

  # implement by ranking?
  def self.front_page_list
    self.all.limit(20)
  end

  def stock_valid
    if self.stock.nil?
      self.stock = 0
    end
  end

  def self.update_stock!(order)
    order.order_items.each do |order_item|
      product = Product.find_by(id: order_item.product_id)
      product.stock -= order_item.quantity
      product.save
    end
  end

end
