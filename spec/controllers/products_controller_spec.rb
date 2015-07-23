require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "#new" do
    it "creates a new product" do
      product = Product.new
      get :new
      expect(product).to be_a_new(Product)
    end


  describe "#create" do
    it "should have 11 products" do
      expect(Product.all.count).to eq(11)
    end

    it "creates a new product with correct attributes" do 
      product = Product.create(name: "Millionaires cc numbers", price: 100000000, description: "Get thousands of dollars of stuff with these rich people's cc numbers",
                               active: true, photo_url: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQxpaGsT8t_USebvf6DGOp_3EFUgm0bXWtVw1NlsWAMNY32D9eZ97HYj8o", user_id: 2)
      post :create
      expect(Product.all.count).to eq(12) 
    end

    it "doesn't create a new product" do
      product = Product.create({name: nil, price: 100000000, 
                                description: "Get thousands of dollars of stuff with these rich people's cc numbers",
                                active: true, photo_url: nil, user_id: 2})
      post :create

      expect(product.errors.messages).to include(:name)
    end
  end
  end


  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  # 
  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
