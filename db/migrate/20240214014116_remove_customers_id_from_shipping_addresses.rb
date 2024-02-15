class RemoveCustomersIdFromShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    remove_column :shipping_addresses, :customers_id
    add_column :shipping_addresses, :customer_id, :integer
  end
end
