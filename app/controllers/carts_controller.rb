class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    session[:cart] ||= Hash.new
    session[:cart][item.id.to_s] ||= 0
    session[:cart][item.id.to_s] += 1
    redirect_to item_path(item), notice: "Item Added to Cart"
  end

  def index
    if current_user
      @current_user = current_user
    end

    if session[:cart]
      @items = session[:cart].inject(Hash.new(0)) do |hash, (item_id, count)|
        item = Item.find(item_id)
        hash[item] = count
        hash
      end
    else
      @items = []
    end
  end

  def update
    item_id = params[:item_id].to_s
    if params[:thing_to_do] == "remove"
      session[:cart].delete(item_id)
    elsif params[:thing_to_do] == "more" && session[:cart][item_id] < Item.find(item_id).inventory_count
      session[:cart][item_id] += 1
    elsif params[:thing_to_do] == "less" && session[:cart][item_id] > 1
      session[:cart][item_id] -= 1
    elsif params[:thing_to_do] == "less" && session[:cart][item_id] == 1
      session[:cart].delete(item_id)
    end
    redirect_to cart_path
  end

  def destroy
    session.delete(:cart)
    redirect_to cart_path
  end

end
