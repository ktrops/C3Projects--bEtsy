class User < ActiveRecord::Base
  has_secure_password
  has_many :products
  has_many :order_items, through: :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def recent_sales
    order_items.order('created_at DESC').limit(5)
  end
end
