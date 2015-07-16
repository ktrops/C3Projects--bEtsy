class Review < ActiveRecord::Base
  belongs_to :product

  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
