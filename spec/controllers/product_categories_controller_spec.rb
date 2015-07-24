require 'rails_helper'

RSpec.describe ProductCategoriesController, type: :controller do
  describe "POST #create" do
    context "valid product_category params" do
      # let(:product) { Product.create(name: "foo", price: 1000, stock: 4) }
      # let(:category) { Category.create(name: "bar") }
      before :each do
        @product = Product.create(name: "foo", price: 1000, stock: 4)
        @category = Category.create(name: "bar")
      end

      let(:valid_params) do
        { product_id: @product.id, category_id: @category.id }
      end

      it "creates a product_category record" do
        post :create, :product_id => @product.id, :product_category => valid_params
        expect(ProductCategory.count).to eq 1
      end
    end
  end
end
