class CreateTableCart < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.datetime :purchased_at
      
      t.timestamps
    end
  end
end
