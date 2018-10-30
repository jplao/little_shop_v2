class Dashboard::ItemsController < ApplicationController

  def index
    @items = Item.where(user_id: current_user.id)
  end

  def new
    if params[:item_params]
      @item = Item.new(new_item_params)
    else
      @item = Item.new
    end
  end

  private

  def new_item_params
    params.require(:item_params).permit(:name, :description, :image,\
      :price, :inventory_count, :user_id, :active)
  end

end
