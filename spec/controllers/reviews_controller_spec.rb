require 'rails_helper'
require 'pry'

RSpec.describe ReviewsController, type: :controller do

  describe "GET #new" do
    before :each do
      @user = User.create(id: 1, username: "lol", email: "lol@lol.com", password: "lol", password_confirmation: "lol")
      @product = Product.create(id: 1, name: "lol", price: 100, stock: 1, length: 2, width: 2, height: 2, weight: 2, user_id: 1)
      @review = Review.new
    end

    it "returns http success and status 200" do
      get :new, product_id: @product.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #create" do
    before :each do
      @user = User.create(id: 1, username: "lol", email: "lol@lol.com", password: "lol", password_confirmation: "lol")
      @product = Product.create(id: 1, name: "lol", price: 100, stock: 1,           length: 2,
                width: 2,
                height: 2,
                weight: 2, user_id: 1)
      @review_params = {
          rating: 3,
          review_text: "lol",
          product_id: 1,
                      }
    end

    it "redirects to product show and returns http status 302" do
      post :create, { product_id: @product.id.to_s, review: @review_params }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(product_path(@product))
    end

    it "creates a review" do
      post :create, { product_id: @product.id, review: @review_params }

      expect(Review.count).to eq(1)
    end

  end

  context "won't accept invalid reviews" do
    before :each do
      @user = User.create(id: 1, username: "lol", email: "lol@lol.com", password: "lol", password_confirmation: "lol")
      @product = Product.create(id: 1, name: "lol", price: 100, stock: 1, user_id: 1,           length: 2,
                width: 2,
                height: 2,
                weight: 2)
      @invalid_params = {
          rating: nil,
          review_text: "lol",
          product_id: 1
      }
    end

    it "renders :new" do
      post :create, { product_id: @product.id.to_s, review: @invalid_params }

      expect(response).to have_http_status(200)
      expect(response).to render_template("new")
    end

    it "not create an invalid review" do
      post :create, { product_id: @product.id, review: @invalid_params }

      expect(Review.count).to eq(0)
    end
  end

  context "converts rating" do
    before :each do
      @user = User.create(id: 2, username: "lol", email: "lol@lol.com", password: "lol", password_confirmation: "lol")
      @product = Product.create(id: 2, name: "lol", price: 100, stock: 1, user_id: 2, length: 2,
                width: 2,
                height: 2,
                weight: 2)
      @review_params = {
          rating: "★★★★☆",
          review_text: "lol",
          product_id: 2
      }
    end

      it "makes stars into integers" do
        post :create, { product_id: @product.id, review: @review_params }

        expect(Review.first.rating).to eq(4)
      end
  end

  context "doesn't convert invalid rating" do
    before :each do
      @user = User.create(id: 2, username: "lol", email: "lol@lol.com", password: "lol", password_confirmation: "lol")
      @product = Product.create(id: 2, name: "lol", price: 100, stock: 1, user_id: 2,          length: 2,
                width: 2,
                height: 2,
                weight: 2)
      @review_params = {
          rating: "★★★★★★",
          review_text: "lol",
          product_id: 2
      }
    end

      it "won't accept invalid stars" do
        post :create, { product_id: @product.id, review: @review_params }

        expect(Review.count).to eq(0)
      end
  end
end
