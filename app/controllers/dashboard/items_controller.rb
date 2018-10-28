class Dashboard::ItemsController < ApplicationController

  def index
    @items = Item.where(user_id: current_user.id)
  end
end
