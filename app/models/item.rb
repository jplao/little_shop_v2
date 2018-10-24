class Item < ApplicationRecord
  validates_presence_of :name, :description, :price, :inventory_count

  belongs_to :user
end
