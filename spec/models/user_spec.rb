require 'rails_helper'

RSpec.describe User, type: :model do
  it "does not persist non-unique user-names"
  User.create!(user_name: 'Octothorpe', email: 'octo@email.com')
  User.create!(user_name: 'Octothorpe', email: 'octodad@email.com')

  expect(User.count).to eq 1
end
