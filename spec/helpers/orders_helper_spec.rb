require 'rails_helper'

RSpec.describe OrdersHelper, type: :helper do
  
  describe "frendly_shipped_status view helper" do
    let(:unshipped_order) { create :order }
    let(:shipped_order) { create :order, shipped: true }

    context "order is shipped" do
      it "returns 'shipped'" do
        expect(frendly_shipped_status(shipped_order.shipped)).to eq "Shipped"
      end
    end
    context "order is not shipped" do
      it "returns 'not shipped'" do
        expect(frendly_shipped_status(unshipped_order.shipped)).to eq "Not Shipped"
      end
    end
  end

  describe "order status view helpers" do
    let(:pending_order) { create :order, status: "pending" }
    let(:paid_order) { create :order, status: "paid" }
    let(:complete_order) { create :order, status: "complete" }
    let(:cancelled_order) { create :order, status: "cancelled" }

    context "pending orders" do
      before :each do
        @order_items = []

        3.times do 
          order_item = create :order_item
          order_item.order = paid_order
          @order_items << order_item
        end

        @first = @order_items.first
        @first.order = pending_order
      end

      it "counts pending orders" do
        expect(pending_orders).to eq 1
      end

      it "counts pending order revenue" do
        @first.product = create :product
        @first.set_item_total
        expect(pending_order_revenue).to eq 40
      end
    end

    context "paid orders" do
      before :each do
        @order_items = []

        3.times do 
          order_item = create :order_item
          order_item.order = pending_order
          @order_items << order_item
        end

        @first = @order_items.first
        @first.order = paid_order
      end

      it "counts paid orders" do
        expect(paid_orders).to eq 1
      end

      it "counts paid order revenue" do
        @first.product = create :product
        @first.set_item_total
        expect(paid_order_revenue).to eq 40
      end
    end

    context "complete orders" do
      before :each do
        @order_items = []

        3.times do 
          order_item = create :order_item
          order_item.order = paid_order
          @order_items << order_item
        end

        @first = @order_items.first
        @first.order = complete_order
      end
      
      it "counts complete orders" do
        expect(complete_orders).to eq 1
      end

      it "counts complete order revenue" do
        @first.product = create :product
        @first.set_item_total
        expect(complete_order_revenue).to eq 40
      end
    end

    context "cancelled orders" do 
      before :each do
        @order_items = []

        3.times do 
          order_item = create :order_item
          order_item.order = paid_order
          @order_items << order_item
        end

        @first = @order_items.first
        @first.order = cancelled_order
      end

      it "counts cancelled orders" do
        expect(cancelled_orders).to eq 1
      end

      it "counts cancelled order revenue" do
        @first.product = create :product
        @first.set_item_total
        expect(cancelled_order_revenue).to eq 40
      end
    end
  end

end
