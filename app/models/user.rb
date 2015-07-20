class User < ActiveRecord::Base
  has_secure_password
  has_many :products
  has_many :order_items, through: :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  # scope :top_five_products, -> order()
  # scope :five_recent_sales, -> order()
end
