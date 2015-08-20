require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the OrdersHelper. For example:
#
# describe OrdersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe OrdersHelper, type: :helper do
  
  describe "order view helpers" do
    let(:unshipped_order) { create :order }
    let(:shipped_order) { create :order, shipped: true }

    context "order is shipped" do
      it "returns 'shipped'" do
        expect(frendly_shipped_status(shipped_order.shipped)).to eq "Shipped"
      end
    end
    context "order is not shipped" do
      it "returns 'not shipped'" do
        expect(frendly_shipped_status(unshipped_order.shipped)).to eq "Not Shipped"
      end
    end
  end
end
