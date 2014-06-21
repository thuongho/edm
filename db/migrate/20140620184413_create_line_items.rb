class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :listing_id
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
