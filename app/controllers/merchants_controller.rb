class MerchantsController < ApplicationController

  def show
    @merchant = User.find(params[:id])
  end

end
