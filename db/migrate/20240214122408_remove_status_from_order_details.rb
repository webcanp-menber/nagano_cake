class RemoveStatusFromOrderDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_details, :status, :boolean
    add_column :order_details, :status, :integer, null: false, default: 1
  end
end
