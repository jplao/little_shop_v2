class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  def item_count
    order_items.sum(:item_quantity)
  end

  def grand_total
    order_items.sum("order_items.item_quantity * order_items.item_price")
  end

  def self.orders_of_merchant(user)
    joins(:items).where("items.user_id = #{user}").uniq
  end

end
