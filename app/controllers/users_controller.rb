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
    no_empty_params = user_params.reject { |k,v| v.empty? }
    if @user.authenticate(no_empty_params[:password])
      @user.update(no_empty_params)
      redirect_to "/profile/#{@user.id}", notice: "Your Data Has Been Updated"
    elsif !no_empty_params[:password]
      redirect_to "/profile/#{@user.id}/edit", notice: "Please Enter Password Before Making Changes"
    else
      redirect_to "/profile/#{@user.id}/edit", notice: "Please Enter CORRECT Password Before Making Changes"
    end
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
