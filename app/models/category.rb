class Category < ActiveRecord::Base
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, uniqueness: { case_sensitive: false }
end
