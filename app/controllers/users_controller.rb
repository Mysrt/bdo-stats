class UsersController < ApplicationController

  def index
  end

  def show
    @guilds = current_user.guilds
    @user = User.find_by_id(params[:user]) || current_user
    if @user.complete?
      @close_aps = current_user.close_ap
      @close_awakening_aps = current_user.close_awakening_ap
      @close_dps = current_user.close_dp
    end

    unless @user.complete?
      flash[:danger] = "Please finish filling out your information to continue.  Necessary fields are:  Name, Family Name, Ap, Awakening Ap, and Dp"
      redirect_to edit_user_path(current_user)
      return
    end
  end

  def edit
    @user = current_user
  end

  def edit_user_settings
    @user = current_user
  end

  def update
    params.permit!

    respond_to do |format|
      if current_user.update_attributes(params[:user])
        format.html {
          flash[:success] = 'Stats Updated'
          sign_in(current_user, :bypass => true)
          redirect_to current_user
        }
      else
        format.html {
          flash[:danger] = "Unable to due to the following errors::  #{current_user.errors.full_messages.join(', ')}"
          redirect_to :back
        }
      end
    end
  end

end

