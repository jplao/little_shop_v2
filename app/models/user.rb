class User < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip
  validates :password, :presence => true, :on => :create
  validates :password, confirmation: {case_sensitive: true}
  validates :email, presence: true, uniqueness: true

  has_secure_password
  has_many :items
  has_many :orders

 enum role: [:user, :merchant, :admin]

  def merchant_orders
    Order.joins(:items).where('items.user_id = ?', self.id)
  end

  def self.top_merchants
    ids = Item.top_seller_ids
    User.where(id: ids)
  end

  def self.return_user_objects(user_id_array)
    where(id: user_id_array)
  end
end
