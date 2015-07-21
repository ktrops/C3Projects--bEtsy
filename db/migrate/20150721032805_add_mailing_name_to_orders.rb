class AddMailingNameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :mailing_name, :string
  end
end
