class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if params[:commit] == "Disable"
      @item.update(active: false)
      redirect_to dashboard_items_path, notice: "Item ##{params[:id]} no longer for sale"
    else
      @item.update(active: true)
        redirect_to dashboard_items_path, notice: "Item ##{params[:id]} now available for sale"
    end
  end

  def create
  end 
end
