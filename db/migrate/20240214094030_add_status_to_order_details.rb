class AddStatusToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :status, :boolean, null: false, default: true
  end
end
