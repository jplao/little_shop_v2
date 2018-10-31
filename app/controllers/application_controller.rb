class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_admin?

  before_action :set_cart

  def current_user
    @current_user_lookup ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def restrict_to_admin_or_self
    if params[:user_id] || params[:id]
      unless current_admin? || current_user.id == params[:user_id]
        redirect_to profile_path, notice: "You don't have permission for that"
      end
    end
  end

end
