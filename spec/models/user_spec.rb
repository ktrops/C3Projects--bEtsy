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
  end

 context "Uniqueness validations" do
   let (:user) { User.new(username: 'octothorpe', email: 'octo@email.com', password: 'himom') }
    it "Username must be unique" do
      user2 = User.new(username: 'octothorpe', email: 'realocto@email.com', password: 'himom')
      expect(user).to_not be_valid
    end

    it "email must be unique" do
      user2 = User.new(username: '8thorpe', email: 'octo@email.com', password: 'himom')
      expect(user).to_not be_valid
    end
  end
end
