class UsersController < ApplicationController

  def index
    if params[:display] == "all"
      @users = User.all
      @header = "Users"
    else
      @users = User.where(role: 1)
      @header = "Merchants"
    end
  end

  def show
    if current_admin? && params[:id]
      @user = User.find(params[:id])
      if @user.role == "merchant"
        redirect_to merchant_path(@user)
      elsif @user.role == "admin"
        redirect_to profile_path
      end
    elsif current_user
      @user = current_user
    else
      redirect_to login_path, notice: "You are not logged in"
    end
  end

  def edit
    if current_admin? && params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if user_params
      no_empty_params = user_params.reject { |k,v| v.empty? }
      if @user.authenticate(no_empty_params[:password])
        if no_empty_params[:new_password]
          no_empty_params[:password] = no_empty_params[:new_password]
          no_empty_params.delete('new_password')
        end
        if current_admin? && @user.update(no_empty_params)
          redirect_to user_path(@user), notice: "User Data Has Been Updated"
        elsif @user.update(no_empty_params)
          redirect_to profile_path, notice: "Your Data Has Been Updated"
        else
          redirect_to profile_edit_path, notice: "That Email Is Already in Use"
        end
      elsif !no_empty_params[:password]
        redirect_to profile_edit_path, notice: "Please Enter Password Before Making Changes"
      else
        redirect_to profile_edit_path, notice: "Please Enter CORRECT Password Before Making Changes"
      end
    else
      if params[:toggle]
        if params[:toggle] == "user"
          @user.role = 1
          @user.save
          redirect_to merchant_path(@user), notice: 'User has been upgraded to merchant'
        elsif params[:toggle] == "merchant"
          @user.role = 0
          @user.save
          redirect_to user_path(@user), notice: 'Merchant has been downgraded to user'
        end
      end
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
        :state, :zip, :password, :email, :password_confirmation, :new_password)
    elsif params[:profile]
      params.require(:profile).permit(:name, :city, :street_address,\
        :state, :zip, :password, :email, :password_confirmation, :new_password)
    else
      nil
    end
  end
end
