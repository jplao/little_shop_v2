class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :image
      t.decimal :price
      t.integer :inventory_count
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
