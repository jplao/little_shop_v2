class OrderItem < ApplicationRecord
  validates_presence_of :item_quantity, :item_price

  belongs_to :item
  belongs_to :order
end
