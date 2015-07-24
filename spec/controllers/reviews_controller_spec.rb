require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  describe "GET #new" do
    before :each do
      @user = User.create(id: 1, username: "lol", email: "lol@lol.com", password: "lol", password_confirmation: "lol")
      @product = Product.create(id: 1, name: "lol", price: 100, stock: 1, user_id: 1)
      @review = Review.new
    end

    it "returns http status 200" do
      get :new, product_id: @product.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  # describe "GET #create" do
  #
  #
  #   it "returns http success" do
  #     post :create,
  #
  #
  #     let(:review_params) do
  #       {
  #         review: {
  #           rating: 5,
  #           review_text: "lol"
  #         }
  #       }
  #     end
  #
  #     expect(response).to be_success
  #     expect(response).to have_http_status(200)
  #   end



end
