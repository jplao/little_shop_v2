class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :cart_count, :current_admin?

  before_action :set_cart

  def current_user
    @current_user_lookup ||= User.find(session[:user_id]) if session[:user_id]
  end

  def cart_count
    if session[:cart]
      session[:cart].inject(0) do |sum, (item_id, count)|
        sum += count
      end
    else
      0
    end
  end

  def set_cart
    @cart_count = cart_count
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
