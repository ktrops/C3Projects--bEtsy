class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :category
      t.boolean :active
      t.string :photo_url
      t.integer :stock

      t.timestamps null: false
    end
  end
end
