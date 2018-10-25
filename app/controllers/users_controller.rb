class UsersController < ApplicationController

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    # The route for this has been changed. It will need to
    # be changed back when we have access to session data for
    # this user
    # @user = User.find(sessions[:id])
  end

  def new
    @user = User.new
  end

  def create
    # binding.pry
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path, notice: "You have successfully registered and have been logged in"
    else
      redirect_to register_path, notice: "Some fields were missing or incorrectly entered. Please try again."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

end
