class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string  :status, default: "pending"
      t.string  :email
      t.string  :cc_name
      t.integer :cc_number
      t.date    :cc_expiration # good until last day of month if no day given
      t.integer :cc_cvv
      t.integer :billing_zip
      t.boolean :shipped
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.string  :state
      t.integer :mailing_zip

      t.timestamps null: false
    end
  end
end
