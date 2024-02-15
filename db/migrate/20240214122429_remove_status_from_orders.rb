class RemoveStatusFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :status, :boolean
    add_column :orders, :status, :integer, null: false, default: 1
  end
end
