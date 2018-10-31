class Admin::UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if current_user.role == 1
      redirect_to merchants_path, notice: "User account has been disabled"
    else
      redirect_to "/users?display=all", notice: "User account has been disabled"
    end
  end

  private
    def user_params
      params.require(:user).permit(:active)
    end
end
