require 'rails_helper'

RSpec.describe Product, type: :model do
  # MODEL VALIDATIONS
  # -----------------
  # belongs_to :user
  # has_many :orders, through: :order_items
  # has_many :order_items
  # has_many :reviews
  #
  # validates :name, presence: true, uniqueness: true
  # validates :price, presence: true, numericality: { greater_than: 0 }
  #
  # def toggle_active!
  #   toggle!(:active)
  # end
  #
  # # implement by ranking?
  # def self.front_page_list
  #   self.all.limit(20)
  # end
  # -----------------

  describe "validates" do
    it ":name presence" do
      product = Product.new

      expect(product).to_not be_valid
      expect(product.errors.keys).to include(:name)
    end

    it ":name uniqueness" do
      named_product = Product.create(name: "CIA operative identity", price: 1_000_000_000)
      same_name_product = Product.new(name: "CIA operative identity", price: 100)

      expect(same_name_product).to_not be_valid
      expect(same_name_product.errors.keys).to include(:name)
    end

    it ":price presence" do
      product = Product.new

      expect(product).to_not be_valid
      expect(product.errors.keys).to include(:price)
    end

    it ":price numericality" do
      lol_product = Product.new(name: "lol", price: "lol")

      expect(lol_product).to_not be_valid
      expect(lol_product.errors.keys).to include(:price)


      yay_product = Product.new(name: "yay", price: 100)

      expect(yay_product).to be_valid
    end

    it ":price > 0" do
      negative_product = Product.new(name: "negative", price: -1)

      expect(negative_product).to_not be_valid
      expect(negative_product.errors.keys).to include(:price)


      zero_product = Product.new(name: "zero", price: 0)

      expect(zero_product).to_not be_valid
      expect(zero_product.errors.keys).to include(:price)


      positive_product = Product.new(name: "positive", price: 1)

      expect(positive_product).to be_valid
    end

  end

end
