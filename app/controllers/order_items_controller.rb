class OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(fulfill: true)
    redirect_to order_path(params[:order_item][:order_id]), notice: "Item has been fulfilled"
    end
end
