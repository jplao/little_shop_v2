class DashboardController < ApplicationController

  def show
    if current_user.role == "merchant"
      @merchant = current_user
    elsif current_admin?
      user_ids = Order.top_user_spending
      @top_spending_users = User.top_spending_users(user_ids)
      @top_three_states = Order.top_three_states
    else
      redirect_to root_path
    end
  end

end
