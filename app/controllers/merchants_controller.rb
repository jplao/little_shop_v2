class MerchantsController < ApplicationController

  def show
      @user = User.find(params[:id])
      if @user.role == "user"
        redirect_to user_path(@user)
      elsif @user.role == "admin"
        redirect_to profile_path
      end
  end

end
