require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do
    it "creates a new user session" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
