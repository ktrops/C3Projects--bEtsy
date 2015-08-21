require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "#new" do

    let(:product) {Product.new}

    it "creates a new product" do
      get :new
      expect(product).to be_a_new(Product)
    end
  end

  describe "#create" do

    let(:count) {Product.all.count}
    let(:user) {User.create(id: 2, username: "Holly Golightly", email: "h.golightly@mail.com", password: "password", password_confirmation: "password")}

    it "creates a new product with correct attributes" do
    user
    product_params = {product: {name: "Millionaires cc numbers",
                        price: "1000",
                        description: "Get thousands of dollars of stuff with these rich people's cc numbers",
                        active: true,
                        photo_url: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQxpaGsT8t_USebvf6DGOp_3EFUgm0bXWtVw1NlsWAMNY32D9eZ97HYj8o",
                        stock: 4,
                        length: 2,
                        width: 2,
                        height: 2,
                        weight: 2},
                        user_id: 2}

      post(:create, product_params, {user_id: 2})
      expect(count).to eq(1)
    end

    it "doesn't create a new product" do
      user
      product_params = {product: {name: nil, price: 100000000,
                                description: "Get thousands of dollars of stuff with these rich people's cc numbers",
                                active: true, photo_url: nil}, user_id: 2}
      post(:create, product_params, {user_id: 2})
      expect(count).to eq(0)
    end
  end

  describe "#update" do
    let(:user) {User.create(id: 2, username: "Holly Golightly", email: "h.golightly@mail.com", password: "password", password_confirmation: "password")}
    let(:product) do
       Product.create(id: 1, name: "Millionaires cc numbers",
        price: "1000",
        description: "Get thousands of dollars of stuff with these rich people's cc numbers",
        active: true,
        photo_url: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQxpaGsT8t_USebvf6DGOp_3EFUgm0bXWtVw1NlsWAMNY32D9eZ97HYj8o",
        stock: 4,
        length: 2,
        width: 2,
        height: 2,
        weight: 2,
        user_id: 2)
    end

    it "updates a product" do
      product
      product_update = Product.find(1)
      product_update.update(name: "So many millionaires")
      expect(product_update.name).to eq("So many millionaires")
    end
  end

  # describe "#merchant_index" do
  #   let(:user) {User.create(id: 1, username: "Doc", email: "doc@mail.com", password: "password", password_confirmation: "password")}
  #   let(:user2) {User.create(id: 2, username: "Holly Golightly", email: "h.golightly@mail.com", password: "password", password_confirmation: "password")}


  # end
end
