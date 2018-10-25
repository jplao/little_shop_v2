class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    if params[:id]
      @user
    else
      @user = current_user
    end
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
    params.require(:profile).permit(:name, :city, :street_address,\
      :state, :zip, :password, :email, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
