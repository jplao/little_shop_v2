class OrdersController < ApplicationController

  def index
    if current_admin?
      @orders = Order.all
    elsif current_user
      @orders = Order.where(user_id: session[:user_id])
    else
      redirect_to login_path, notice: "You are not logged in"
    end
  end

  def show
  end

  def destroy
    order = Order.find(params[:id])
    order.update(status: "cancelled")
    redirect_to profile_orders_path
  end
end
