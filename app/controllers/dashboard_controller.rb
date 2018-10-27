class DashboardController < ApplicationController

  def show
    if current_user.role == "merchant"
      @merchant = current_user
    else
      redirect_to root_path
    end
  end

end
