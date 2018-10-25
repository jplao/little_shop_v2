class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path, notice: "You have successfully logged in"
    elsif user
      redirect_to login_path, notice: "Password does not match username. Please try again."
    else
      redirect_to login_path, notice: "Could not log in. Please try again."
    end
  end
end
