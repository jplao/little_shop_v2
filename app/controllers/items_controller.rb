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
      active_status = false
    else
      active_status = true
    end
    @item.update(active: active_status)
    redirect_to dashboard_items_path, notice: "Item ##{params[:id]} no longer for sale"
  end
end
