class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    session[:cart] ||= Hash.new
    session[:cart][item.id.to_s] ||= 0
    session[:cart][item.id.to_s] += 1
    redirect_to item_path(item), notice: "Item Added to Cart"
  end

  def index
    @items = session[:cart].inject(Hash.new(0)) do |hash, (item_id, count)|
      item = Item.find(item_id)
      hash[item] = count
      hash
    end
  end
end
