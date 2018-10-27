class Dashboard::OrdersController < ApplicationController

  def index
    @orders = Order.orders_of_merchant(current_user.id)
  end

end
