class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    redirect_to item_path(item), notice: "Item Added to Cart"
  end

  def index
    @current_user = current_user if current_user
    @items = @cart.item_quantity_hash
  end

  def update
    item_id = params[:item_id].to_s
    method = params[:thing_to_do]
    @cart.update_item(item_id, method)

    redirect_to cart_path
  end

  def destroy
    session.delete(:cart)
    redirect_to cart_path
  end

end
