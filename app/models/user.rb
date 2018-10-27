class User < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip
  validates :password, presence: true
  validates :password, confirmation: {case_sensitive: true}
  validates :email, presence: true, uniqueness: true

  has_secure_password
  has_many :items
  has_many :orders

  def merchant_orders
    Order.joins(:items).where('items.user_id = ?', self.id)
  end
end
