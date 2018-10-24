class AddUsersToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :user, foreign_key: true
  end
end
