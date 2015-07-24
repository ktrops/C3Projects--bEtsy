require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe "POST #create" do
    context "valid order_item params" do
      before :each do
        @product = Product.create(name: "foo", price: 1000, stock: 4)
        session[:order_id] = 1
        @order = Order.create(id: session[:order_id])
      end

      let(:valid_params) do
        { product_id: @product.id, order_id: @order.id, quantity: 3 }
      end

      it "creates a order_item record" do
        post :create, :product_id => @product.id, :order_item => valid_params
        expect(OrderItem.count).to eq 1
      end

      it "redirects to same page" do
        post :create, :product_id => @product.id, :order_item => valid_params
        expect(response).to redirect_to @product
      end
    end
  end
end
