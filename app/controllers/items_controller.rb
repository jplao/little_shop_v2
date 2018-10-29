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
    required_parmas[:name] = item_params[:name]
    required_parmas[:description] = item_params[:description]
    price = item_params[:price]

    if required_parmas[:name]

    @item = Item.new(item_params)
    @item.save
    redirect_to dashboard_items_path, notice: "You have successfully added a new item"
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :image,\
      :price, :inventory_count, :user_id, :active)
  end
end
