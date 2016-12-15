class UsersController < ApplicationController

  def index
  end

  def show
    @guilds = current_user.guilds
    @user = User.find_by_id(params[:user]) || current_user

  end

end

