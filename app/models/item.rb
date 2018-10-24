class Item < ApplicationRecord
  validates_presence_of :name, :description, :price, :inventory_count

end
