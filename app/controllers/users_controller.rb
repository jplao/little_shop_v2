class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    # The route for this has been changed. It will need to
    # be changed back when we have access to session data for
    # this user
    # @user = User.find(sessions[:id])
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to "/profile/#{@user.id}", notice: "Your Data Has Been Updated"
  end

  private

  def user_params
    params.require(:profile).permit(:name, :city, :street_address,\
      :state, :zip, :password, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end



end
