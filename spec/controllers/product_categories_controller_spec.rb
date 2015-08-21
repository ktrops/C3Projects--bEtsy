require 'rails_helper'

RSpec.describe ProductCategoriesController, type: :controller do
  describe "POST #create" do
    context "valid product_category params" do
      before :each do
        @product = Product.create(name: "foo", price: 1000, stock: 4, length: 2, width: 2, height: 2, weight: 2)
        @category = Category.create(name: "bar")
      end

      let(:valid_params) do
        { product_id: @product.id, category_id: @category.id }
      end

      it "creates a product_category record" do
        post :create, :product_id => @product.id, :product_category => valid_params
        expect(ProductCategory.count).to eq 1
      end

      it "redirects to same page" do
        post :create, :product_id => @product.id, :product_category => valid_params
        expect(response).to redirect_to @product
      end
    end
  end

  describe "POST #create_category" do
    let(:category_params) do {
      category:{
        name: 'video games'
      }
    }
    end

    it "creates a new category" do
      session[:previous_page] = root_path
      post :create_category, category_params
      expect(Category.count).to eq 1
    end
  end
end
