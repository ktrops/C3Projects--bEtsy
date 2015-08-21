require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "#finalize" do
    let(:order) do
      Order.create(status: "pending", 
        email: "joe@mail.com", 
        cc_name: "Joe Smoe", 
        cc_number: "0000123456781234",
        cc_cvv: 567, 
        billing_zip: 98740, 
        shipped: false, 
        address1: "123 Main St",
        address2: "apt #2", 
        city: "Kent", 
        state: "WA", 
        mailing_name: "Joe Smoe",
        mailing_zip: 98740)
    end

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
