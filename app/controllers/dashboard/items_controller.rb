class Dashboard::ItemsController < ApplicationController

  def index
    @merchant = current_user
    if current_admin? && params[:merchant_id]
      @merchant = User.find(params[:merchant_id])
    end
    @items = Item.where(user_id: @merchant.id)
  end

  def new
    @merchant = current_user
    if current_admin? && params[:merchant_id]
      @merchant = User.find(params[:merchant_id])
    end
    # if params[:item_params]
    #   @item = Item.new(new_item_params)
    # else
      @item = Item.new
    # end
  end

  def create
    @merchant = User.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    if @item.save && @merchant == current_user
      redirect_to dashboard_items_path, notice: "You have successfully added a new item"
    elsif @item.save
      redirect_to merchant_items_path(@merchant), notice: "You have successfully added a new item"
    else
      # redirect_to new_dashboard_item_path(item_params: item_params), notice: "All required fields must be filled in"
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :image,\
      :price, :inventory_count, :user_id, :active)
  end

  # def new_item_params
  #   params.require(:item_params).permit(:name, :description, :image,\
  #     :price, :inventory_count, :user_id, :active)
  # end

end
