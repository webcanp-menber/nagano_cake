class RemoveCustomersIdFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :customers_id, :integer
  end
end
