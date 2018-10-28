class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    session[:cart] ||= Hash.new
    session[:cart][item.id.to_s] ||= 0
    session[:cart][item.id.to_s] += 1
    redirect_to item_path(item), notice: "Item Added to Cart"
  end

  def index
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
    if params[:thing_to_do] == "remove"
      session[:cart].delete(params[:item_id].to_s)
    end
    redirect_to cart_path
  end

  def destroy
    session.delete(:cart)
    redirect_to cart_path
  end

end
