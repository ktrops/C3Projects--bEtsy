class AddAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string, default: "US"
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :zip, :string
  end
end
