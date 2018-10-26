class UsersController < ApplicationController

  def show
    if params[:id]
      @user = User.find(params[:id])
    elsif current_user
      @user = current_user
    else
      redirect_to login_path, notice: "You are not logged in"
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
      redirect_to profile_path, notice: "Your Data Has Been Updated"
    elsif !no_empty_params[:password]
      redirect_to profile_edit_path, notice: "Please Enter Password Before Making Changes"
    else
      redirect_to profile_edit_path, notice: "Please Enter CORRECT Password Before Making Changes"
    end
  end

  def new
    if session[:user]
      session[:user][:email] = nil
      @user = User.new(session[:user])
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path, notice: "You have successfully registered and have been logged in"
    elsif User.find_by(email: user_params[:email])
      session[:user] = @user
      flash[:notice] = "That email is already in use. Try again"
      redirect_to register_path
    else
      redirect_to register_path, notice: "Some fields were missing or incorrectly entered. Please try again."
    end
  end

  private

  def user_params
    if params[:user]
      params.require(:user).permit(:name, :city, :street_address,\
        :state, :zip, :password, :email, :password_confirmation)
    else
      params.require(:profile).permit(:name, :city, :street_address,\
        :state, :zip, :password, :email, :password_confirmation)
    end
  end
end
