class Admin::UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to merchants_path
  end

  private
    def user_params
      params.require(:user).permit(:active)
    end
end
