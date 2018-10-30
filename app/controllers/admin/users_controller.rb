class Admin::UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if !@user.active
      
    end
    redirect_to merchants_path, notice: "User account has been disabled"
  end

  private
    def user_params
      params.require(:user).permit(:active)
    end
end
