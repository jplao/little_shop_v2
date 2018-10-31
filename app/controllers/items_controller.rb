class ItemsController < ApplicationController

  def index
    @items = Item.where(active: true)
    @top_item = Item.top_items
    @top_merch = User.top_merchants
    @quick_merch = User.ordered_by_time_to_filfill("DESC")
    @slow_merch = User.ordered_by_time_to_filfill("ASC")
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if current_admin? && (params[:commit] == "Disable" || params[:commit] == "Enable")
      notice = toggle_item(params[:commit])
      redirect_to merchant_items_path(@item.user), notice: notice
    elsif current_admin?
      notice = update_item(item_params)
      redirect_to merchant_items_path(@item.user), notice: notice
    elsif params[:commit] == "Disable" || params[:commit] == "Enable"
      notice = toggle_item(params[:commit])
      redirect_to dashboard_items_path, notice: notice
    elsif params[:commit] == "Update Item"
      notices = update_item(item_params)
      redirect_to dashboard_items_path, notice: notices
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
