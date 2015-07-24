require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  before :each do
    @product = Product.create(name: "foo", price: 1000, stock: 4)
    session[:order_id] = 1
    @order = Order.create(id: session[:order_id])
  end

  let(:valid_params) do
    { product_id: @product.id, order_id: @order.id, quantity: 1 }
  end

  describe "POST #create" do
    context "valid order_item params" do
      it "creates a order_item record" do
        post :create, :product_id => @product.id, :order_item => valid_params
        expect(OrderItem.count).to eq 1
      end

      it "redirects to same page" do
        post :create, :product_id => @product.id, :order_item => valid_params
        expect(response).to redirect_to @product
      end
    end

    context "invalid quantity" do
      let(:invalid_params) do
        { product_id: @product.id, order_id: @order.id, quantity: 5 }
      end

      it "doesn't create an order_item" do
        post :create, :product_id => @product.id, :order_item => invalid_params
        expect(OrderItem.count).to eq 0
      end
    end

    context "previous order_item for same product & order exists" do
      before :each do
        @prev_order_item = OrderItem.create(product_id: @product.id, order_id: @order.id, quantity: 2)
      end

      it "doesn't create a new order_item" do
        post :create, :product_id => @product.id, :order_item => valid_params
        expect(OrderItem.count).to eq 1
      end

      it "quantity of prev_order_item is increased" do
        post :create, :product_id => @product.id, :order_item => valid_params
        expect(OrderItem.find(@prev_order_item.id).quantity).to eq 3
      end
    end
  end

  describe "PUT #update" do
    let(:current_order_item) { OrderItem.create(valid_params) }

    context "valid quantity" do
      before :each do
        put :update, id: current_order_item, :order_item => { quantity: 2 }
      end

      it "updates quantity by amount passed in" do
        current_order_item.reload
        expect(current_order_item.quantity).to eq 2
      end
    end

    context "quantity can't be increased to be over stock of product" do
      before :each do
        put :update, id: current_order_item, :order_item => { quantity: 5 }
      end

      it "doesn't update quantity" do
        current_order_item.reload
        expect(current_order_item.quantity).to eq 1
      end
    end
  end
end
