require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      post :create, product_id: product.id, review_params
      let(:product) do
        {
          product: {
            id: 1,
            name: "lol",
            price: 100,
          }
        }
      end
      let(:review_params)do
        {
          review: {
            rating: 5,
            review_text: "lol"
          }
        }
      end

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end



end
