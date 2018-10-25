class UsersController < ApplicationController

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def edit
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def update
    @user = User.find(params[:id])
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

  def new
    @user = User.new
  end

  def create
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
<<<<<<< HEAD
    params.require(:profile).permit(:name, :city, :street_address,\
      :state, :zip, :password, :email, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
=======
    params.require(:user).permit(:name, :city, :street_address,\
      :state, :zip, :password, :email, :password_confirmation)
>>>>>>> ac47e358df633eb8bfff5a9c7575266adeff250a
  end
end
