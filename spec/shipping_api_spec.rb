require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe InstagramApi do
  let(:shipping_api) { ShippingApi.new }

  describe "#calc_shipping" do
    it "returns a json response" do
      VCR.use_cassette 'shipping_api/calc_shipping' do
        results = shipping_api.calc_shipping("state=WA&city=seattle&zip=98101&o_state=WA&o_city=seattle&o_zip=98101&packages[][length]=12.0&packages[][width]=10.0&packages[][height]=2.0&packages[][weight]=1.0")
        expect(results.count).to be <= 3
      end
    end
  end
