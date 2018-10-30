class ItemsController < ApplicationController

  def index
    @items = Item.where(active: true)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if params[:commit] == "Disable" || params[:commit] == "Enable"
      notice = toggle_item(params[:commit])
      redirect_to dashboard_items_path, notice: notice
    elsif params[:commit] == "Update Item"
      notices = update_item(item_params)
      redirect_to dashboard_items_path, notice: notices
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to dashboard_items_path, notice: "You have successfully added a new item"
    else
      redirect_to new_dashboard_item_path(item_params: item_params), notice: "All required fields must be filled in"
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :image,\
      :price, :inventory_count, :user_id, :active)
  end

  def toggle_item(enable_disable)
    if enable_disable == "Enable"
      @item.update(active: true)
      notice = "Item ##{params[:id]} now available for sale"
    elsif enable_disable == "Disable"
      @item.update(active: false)
      notice = "Item ##{params[:id]} no longer for sale"
    end
    return notice
  end

  def update_item(params)
    notices = []
    notices << "Name Cannot Be Blank" if params[:name].empty?
    notices << "Description Cannot Be Blank" if params[:description].empty?
    notices << "Price Must Be Greater Than $0" if params[:price].to_i <= 0
    notices << "Inventory Must Be Greater Than $0" if params[:inventory_count].to_i <= 0
    if notices.empty?
      @item.update(params)
      notices << "Item Has Been Updated"
    end
    return notices
  end

end
