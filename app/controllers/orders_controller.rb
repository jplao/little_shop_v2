class OrdersController < ApplicationController

  before_action :restrict_to_admin_or_self, only: [:index]

  def index
    if current_admin? && params[:user_id]
      @orders = Order.where(user_id: params[:user_id])
    elsif current_admin? && params[:merchant_id]
      @orders = Order.orders_of_merchant(params[:merchant_id])
    elsif current_admin?
      @orders = Order.all
    elsif current_user
      @orders = Order.where(user_id: session[:user_id])
    else
      redirect_to login_path, notice: "You are not logged in"
    end
  end

  def show
    user_id = Order.find(params[:id]).user_id
    @user = User.find(user_id)
    if current_user.role == "merchant"
      @order = Order.find(params[:id])
      @order_items = OrderItem.where(order_id: @order.id)
    end
  end

  def create
    if session[:cart]
      order_items_array = OrderItem.cart_checkout(session[:cart])
      current_user.orders.create(order_items: order_items_array)
      redirect_to profile_orders_path
    else
      redirect_to profile_orders_path, notice: "You have no items in your cart"
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.update(status: "cancelled")
    OrderItem.where(order: order).update_all(active: false)
    if current_admin?
      redirect_to orders_path
    else
      redirect_to profile_orders_path
    end
  end

  protected

  def restrict_to_admin_or_self
    super
  end

end
