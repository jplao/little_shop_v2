class OrderItem < ApplicationRecord
  validates_presence_of :item_quantity, :item_price

  belongs_to :item
  belongs_to :order

  def self.cart_checkout(cart)

    order_items = []
    cart.each do |item_id, quantity|
      price = Item.find(item_id).price

      order_items << OrderItem.create(item_id: item_id.to_i, item_quantity: quantity, item_price: price)
    end
    order_items
  end

end
