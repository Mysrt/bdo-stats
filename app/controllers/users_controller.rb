class UsersController < ApplicationController

  def index
  end

  def show
    @guilds = current_user.guilds
    @user = User.find_by_id(params[:user]) || current_user
  end

  def edit
    @user = current_user
  end

  def update
    params.permit!

    current_user.update_attributes(params[:user])
    respond_to do |format|
      format.html {
        flash[:success] = 'Stats Updated'
        redirect_to current_user
      }
    end
  end

end

