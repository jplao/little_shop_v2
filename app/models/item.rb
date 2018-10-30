class Item < ApplicationRecord
  validates_presence_of :name, :description, :price, :inventory_count

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.reduce_inventory(order_item)
    item = Item.find(order_item.item_id)
    new_inventory = item.inventory_count - order_item.item_quantity
    item.update(inventory_count: new_inventory)
  end

end
