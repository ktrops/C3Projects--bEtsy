require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "validations presence: true" do
    context "valid" do
      let(:order_item) { OrderItem.create(quantity: 4)}
      it "creates a valid instance" do
        expect(order_item).to be_valid
        expect(order_item.errors.keys).to_not include(:quantity)
      end
    end
    context "invalid" do
      let(:order_item) { OrderItem.create(quantity: nil)}
      it "is an invalid instance" do
        expect(order_item).to_not be_valid
        expect(order_item.errors.keys).to include(:quantity)
      end
    end

  end
  describe "validations numercality: true" do
    context "valid" do
      let(:order_item) { OrderItem.create(quantity: 2)}
      it "should be an fixnum" do
        expect(order_item.quantity.class).to eq(Fixnum)
        expect(order_item.errors.keys).to_not include(:quantity)
      end
    end
    context "invalid" do
      let(:order_item) { OrderItem.create(quantity: 5.34)}
      it "should not be a valid instance" do
        expect(order_item).to_not be_valid
        expect(order_item.errors.keys).to include(:quantity)
      end
    end
  end
end
