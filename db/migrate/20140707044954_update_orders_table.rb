class UpdateOrdersTable < ActiveRecord::Migration
  def up
    remove_column :orders, :address, :string
    remove_column :orders, :city, :string
    remove_column :orders, :state, :string
    remove_column :orders, :seller_id, :integer
    add_column :orders, :cart_id, :integer
    add_column :orders, :ip, :integer
    add_column :orders, :express_token, :string
    add_column :orders, :express_payer_id, :string
  end

  def down
    remove_column :orders, :express_payer_id, :string
    remove_column :orders, :express_token, :string
    remove_column :orders, :ip, :integer
    remove_column :orders, :cart_id, :integer
    add_column :orders, :seller_id, :integer
    add_column :orders, :state, :string
    add_column :orders, :city, :string
    add_column :orders, :address, :string
  end
end
