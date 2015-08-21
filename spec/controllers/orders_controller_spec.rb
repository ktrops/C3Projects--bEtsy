require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create :user }
  let(:basic_order) { create :order }

  before :each do
    session[:user_id] = user.id
  end

  describe "GET #show" do
    it "returns http redirect" do
      get :show, user_id: user.id, id: basic_order.id
      expect(response).to have_http_status(:redirect)
    end

    # it "finds the current order" do
    #   user.order << basic_order
    #   get :show, user_id: user.id, id: basic_order.id
    #   expect(assigns(@order)).to basic_order
    # end
  end

  describe "#finalize" do
    let(:order) { create :order }

    let(:order_params) do
      {status: "paid",
        email: "joe@mail.com",
        cc_name: "Joe Smoe",
        cc_number: "0000123456781234",
        cc_cvv: 567,
        cc_expiration: Date.tomorrow,
        billing_zip: 98740,
        shipped: false,
        address1: "123 Main St",
        address2: "apt #2",
        city: "Kent",
        state: "WA",
        mailing_name: "Joe Smoe",
        mailing_zip: 98740}
    end

    it "changes order status" do
      order
      session[:order_id] = order.id

      put :finalize, { id: order.id, order: order_params }
      order.reload

      expect(order.status).to eq("paid")
    end
  end

end
