class DashboardController < ApplicationController

  def show
    if current_user.role == 1
      @merchant = current_user
    else
      redirect_to root_path
    end
  end

end
