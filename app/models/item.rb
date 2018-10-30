class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates :price, numericality: {greater_than: 0}, presence: true
  validates :inventory_count, numericality: {greater_than: 0}, presence: true

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.reduce_inventory(order_item)
    @item = Item.find(order_item.item_id)
    new_inventory = @item.inventory_count - order_item.item_quantity
    @item.update(inventory_count: new_inventory)
  end

  def self.top_items(limit = 5)
   select('items.*, sum(order_items.item_quantity) as tot_items')
     .joins(:order_items)
     .group(:id, :item_id)
     .order('tot_items desc')
     .limit(limit)
  end

  def self.top_seller_ids(limit = 5)
   select('items.*, sum(order_items.item_quantity) as tot_items')
     .joins(:order_items)
     .group(:user_id, :id, :item_id)
     .order('tot_items desc')
     .limit(limit)
     .uniq
     .pluck(:user_id)
  end



end
