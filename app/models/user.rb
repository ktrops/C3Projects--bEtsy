class User < ActiveRecord::Base
  has_secure_password
  has_many :products
  has_many :order_items, through: :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  # scope :ordered_by_rating, -> { order('board_games.rating DESC') }
  # scope :top_five_products, -> { order(:user.products.) }
  scope :five_recent_sales, -> { order('user.order_items.created_at DESC limit: 5') }
end
