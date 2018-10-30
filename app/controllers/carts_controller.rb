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
    # if params[:thing_to_do] == "remove"
    #   session[:cart].delete(item_id)
    # elsif params[:thing_to_do] == "more" && session[:cart][item_id] < Item.find(item_id).inventory_count
    #   @cart.add_item(item_id)
    # elsif params[:thing_to_do] == "less" && session[:cart][item_id] > 1
    #   session[:cart][item_id] -= 1
    # elsif params[:thing_to_do] == "less" && session[:cart][item_id] == 1
    #   session[:cart].delete(item_id)
    # end
    @cart.update_item(item_id, method)

    redirect_to cart_path
  end

  def destroy
    session.delete(:cart)
    redirect_to cart_path
  end

end
