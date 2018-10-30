class AddColumnToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :active, :boolean, default: true
    add_column :order_items, :fulfill, :boolean, default: false
  end
end
