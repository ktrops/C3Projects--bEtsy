require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "validations" do
    it "name is present" do
      product = Product.new

      expect(product).to_not be_valid
      expect(product.errors.keys).to include(:name)
    end

    it "name is unique" do
      Product.create(name: "CIA operative identity", price: 1_000_000_000, stock: 1)
      same_name_product = Product.new(name: "CIA operative identity", price: 100, stock: 1)

      expect(same_name_product).to_not be_valid
      expect(same_name_product.errors.keys).to include(:name)
    end
    
    it "price is present" do
      product = Product.new

      expect(product).to_not be_valid
      expect(product.errors.keys).to include(:price)
    end

    it "price is a number" do
      lol_product = Product.new(name: "lol", price: "lol", stock: 1)

      expect(lol_product).to_not be_valid
      expect(lol_product.errors.keys).to include(:price)


      yay_product = Product.new(name: "yay", price: 100, stock: 1)

      expect(yay_product).to be_valid
    end

    context "price > 0" do
      it "price can't be negative" do
        negative_product = Product.new(name: "negative", price: -1, stock: 1)

        expect(negative_product).to_not be_valid
        expect(negative_product.errors.keys).to include(:price)
      end

      it "price can't be 0" do
        zero_product = Product.new(name: "zero", price: 0, stock: 1)

        expect(zero_product).to_not be_valid
        expect(zero_product.errors.keys).to include(:price)
      end


      it "price can be more than 1" do
        positive_product = Product.new(name: "positive", price: 1, stock: 1)

        expect(positive_product).to be_valid
      end
    end

    context "associations" do
      it "belongs to User" do
        User.create(id: 1, username: "Hackman", email: "hackman@hackers.hack", password: "password", password_confirmation: "password")
        nk_product = Product.create(name: "Kim Jeong Un's twitter", price: 100_000, stock: 1, user_id: 1)

        expect(nk_product.user.username).to eq("Hackman")
      end

      context "multiple orders and items" do
        before :each do
          OrderItem.create(quantity: 1, product_id: 2, order_id: 3)
          OrderItem.create(quantity: 1, product_id: 2, order_id: 4)
          Order.create(id: 3)
          Order.create(id: 4)
          @product = Product.create(id: 2, name: "lol", price: 100, stock: 1)
        end

        it "has many orders through order items" do
          expect(@product.orders.count).to eq(2)
        end

        it "has many order items" do
          expect(@product.order_items.count).to eq(2)
        end
      end

      it "has many reviews" do
        product = Product.create(id: 3, name: "Secret Sauce", price: 100, stock: 1)
        Review.create(rating: 5, product_id: 3)
        Review.create(rating: 1, product_id: 3)

        expect(product.reviews.count).to eq(2)
      end

      context "multiple product categories" do
        before :each do
          @product = Product.create(id: 4, name: "Joe Biden's hotmail", price: 100, stock: 1)
          Category.create(id: 10, name: "password")
          Category.create(id: 11, name: "state secret")
          ProductCategory.create(product_id: 4, category_id: 10)
          ProductCategory.create(product_id: 4, category_id: 11)
        end

        it "has many categories" do
          expect(@product.categories.count).to eq(2)
        end

        it "has many product_categories" do
          expect(@product.product_categories.count).to eq(2)
        end
      end
    end # context associations

    describe "can be toggled between active and inactive" do
      it "can be toggled to active" do
        product = Product.create(name: "Was Inactive", price: 100, stock: 1, active: false)
        product.toggle_active!

        expect(product.active).to be(true)
      end

      it "can be toggled to inactive" do
        product = Product.create(name: "Was Active", price: 100, stock: 1, active: true)
        product.toggle_active!

        expect(product.active).to be(false)
      end
    end

    describe "automatically inactive when out of stock" do
      it "will be active when in stock" do
        product = Product.create(name: "has stock", price: 100, stock: 1, active: true)

        expect(product.active).to eq(true)
      end

      it "will be inactive when out of stock" do
        product = Product.create(name: "has stock", price: 100, stock: 0)

        expect(product.active).to eq(false)
      end
    end

  end # validations

end # class Product model
