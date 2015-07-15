require 'rails_helper'

RSpec.describe Order, type: :model do
  context "validations" do
    %w(pending paid complete cancelled).each do |order_status|
      it "order status '#{order_status}' permitted" do
        order = Order.create(status: order_status)
        expect(order).to be_valid
      end
    end

    ["done", 0, true].each do |order_status|
      it "order status '#{order_status}' not permitted" do
        order = Order.create(status: order_status)
        expect(order).to_not be_valid
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
