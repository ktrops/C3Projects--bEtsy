require 'rails_helper'

RSpec.describe User, type: :model do
  context "Presence validations" do
    it "Users must have a username" do
      user = User.new(email: 'octo@email.com', password: 'himom')
      expect(user).to_not be_valid
    end

    it "Users must have an email" do
      user = User.new(username: 'octothorpe', password: 'himom')
      expect(user).to_not be_valid
    end
  end # end of context

 context "Uniqueness validations" do
   let (:user) { User.new(username: 'octothorpe', email: 'octo@email.com', password: 'himom') }
   before(:each) do
    user.save
   end
   after(:each) do
    user.destroy
   end
   it "Username must be unique" do
      user2 = User.new(username: 'octothorpe', email: 'realocto@email.com', password: 'himom')
      expect(user2).to_not be_valid
    end

    it "email must be unique" do
      user2 = User.new(username: '8thorpe', email: 'octo@email.com', password: 'himom')
      expect(user2).to_not be_valid
    end
  end # end of context

  context "User has many products and many order_items through product" do
    let (:user) { User.new(id: 1, username: 'octothorpe', email: 'octo@email.com', password: 'himom', password_confirmation: 'himom') }
    let (:product) { Product.new(id: 1, name: 'Rupert Murdoch\'s Fox corp Login', price: 1000, user_id: 1)}
    let (:item) { OrderItem.new(id: 1, quantity: 7, product_id: 1)}
    before(:each) do
      user.save
      product.save
      item.save
      user.products << product
    end
    after(:each) do
      user.destroy
      item.destroy
      product.destroy
    end
    it "has many products" do
      expect(user.products.first).to eq(product)
    end
    it "has many order items through products" do
      expect(user.products.first.order_items.first).to eq(item)
    end
  end
end # end of describe
