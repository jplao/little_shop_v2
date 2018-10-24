class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # The route for this has been changed. It will need to
    # be changed back when we have access to session data for
    # this user
    # @user = User.find(sessions[:id])
  end

end
