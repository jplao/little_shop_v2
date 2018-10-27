class CartsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    session[:cart] ||= Hash.new
    session[:cart][item.id] ||= 0
    session[:cart][item.id] += 1

    # if session[:cart][item.id]
    #   session[:cart][item.id] + 1
    # else
    #   session[:cart][item.id] = 1
    # end
    redirect_to item_path(item), notice: "Item Added to Cart"
  end
end
