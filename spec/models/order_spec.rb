require 'rails_helper'

RSpec.describe Order, type: :model do
  context "validations" do
    context "order_status" do
      %w(pending paid complete cancelled).each do |order_status|
        it "order status '#{order_status}' permitted" do
          order = Order.create(status: order_status)
          expect(order).to be_valid
          expect(order.errors.keys).to_not include :status
        end
      end

      ["done", 0, true].each do |order_status|
        it "order status '#{order_status}' not permitted" do
          order = Order.create(status: order_status)
          expect(order).to_not be_valid
          expect(order.errors.keys).to include :status
        end
      end
    end

    context "credit card number" do
      context "length" do
        ["123456781234567", "1234567812345678"].each do |valid_cc_num|
          it "cc_number can be #{valid_cc_num.length} digits" do
            order = Order.new(cc_number: valid_cc_num)
            expect(order).to be_valid
            expect(order.errors.keys).to_not include :cc_number
          end
        end

        ["12345678123456", "12345678123456789"].each do |invalid_cc_num|
          it "cc_number cannot be #{invalid_cc_num.length} digits" do
            order = Order.new(cc_number: invalid_cc_num)
            expect(order).to_not be_valid
            expect(order.errors.keys).to include :cc_number
          end
        end

        it "can create an order without any cc_number" do
          order = Order.new
          expect(order).to be_valid
          expect(order.errors.keys).to_not include :cc_number
        end
      end

      context "integer_only" do
        it "cc_number cannot be a float" do
          order = Order.new(cc_number: "12345678123456.8")
          expect(order).to_not be_valid
          expect(order.errors.keys).to include :cc_number
        end

        it "cc_number cannot be non-numerical" do
          order = Order.new(cc_number: "hellohellohello")
          expect(order).to_not be_valid
          expect(order.errors.keys).to include :cc_number
        end
      end
    end
  end

  # context "associations" do
  #   let(:order) { Order.create() }
  #   let(:user) { User.create(username: "Ms. Spy") }
  #   let(:product) { Product.create(name: "secrets", user_id: user.id) }
  #   it "can access order_items" do
  #     3.times do
  #       OrderItem.create(product_id: product.id, order_id: order.id)
  #     end

  #     expect(order.order_items.count).to eq 3
  #   end
  # end
end
