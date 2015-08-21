class RemoveTrackingFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :tracking_number, :string
  end
end
