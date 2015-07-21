class Product < ActiveRecord::Base
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
end
