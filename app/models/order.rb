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

  def self.orders_of_merchant(user_id)
    joins(:items).where("items.user_id = #{user_id}").uniq
  end

  def self.top_three_states
    select("users.state, count(orders.id) AS order_count").joins(:user).group("users.state").where(status: "complete").order('order_count desc').limit(3).uniq.pluck(:state)
  end

  def self.top_user_spending
    select("orders.*, sum(order_items.item_quantity * order_items.item_price) AS total_spent").joins(:order_items).group("orders.user_id, order_items.order_id, orders.id").order("total_spent desc").limit(3).uniq.pluck(:user_id)
  end

  def self.top_orders_by_items
    select("orders.*, sum(order_items.item_quantity) AS item_count").joins(:order_items).group("orders.id").order("item_count desc").limit(3)
  end

end
