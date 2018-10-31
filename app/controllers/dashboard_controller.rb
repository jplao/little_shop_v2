class DashboardController < ApplicationController

  def show
    if current_user.role == "merchant"
      @merchant = current_user
    elsif current_admin?
      user_ids = Order.top_user_spending
      @top_spending_users = User.return_user_objects(user_ids)
      @top_three_states = Order.top_three_states
      @top_orders_by_items = Order.top_orders_by_items
      merch_ids = Item.top_merchant_sales
      @top_merchants_by_sales = User.return_user_objects(merch_ids)
    else
      redirect_to root_path
    end
  end

end
