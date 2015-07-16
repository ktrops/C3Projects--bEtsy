require 'rails_helper'

RSpec.describe User, type: :model do

  it "does not persist non-unique user-names" do
    User.create!(username: 'Octothorpe', email: 'octo@email.com', password: "himom")
    User.create!(username: 'Octothorpe', email: 'octodad@email.com', password: "himom")

    expect(User.count).to eq 1
  end
end
