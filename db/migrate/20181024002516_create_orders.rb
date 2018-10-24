class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status, default: "pending"
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
