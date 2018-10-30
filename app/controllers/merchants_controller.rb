class MerchantsController < ApplicationController

  def show
    @merchant = User.find(params[:id])
    if @merchant.role == "user"
      redirect_to user_path(@merchant)
    end
  end

end
