class GuildMembershipsController < ApplicationController

  def create
    @guild_membership = GuildMembership.find_by_invite_hash(params.permit(:invite_hash)[:invite_hash])

    unless @guild_membership
      flash[:danger] = "Invite does not exist"
      redirect_to root_path
      return
    end

    @guild = @guild_membership.guild
    #unless @guild.membership_for(current_user)
      @new_membership = @guild.guild_memberships.create(user: current_user, invitor_id: @guild_membership.user_id)
    #end

    respond_to do |format|
      if @new_membership
        format.html {
          flash[:success] = "Welcome to #{@guild.name}"
          redirect_to @guild
        }

      else 
        format.html {
          flash[:danger] = "You cannot join this guild, #{@new_membership.errors.full_messages.join(', ') if @new_membership}"
          redirect_to @guild || current_user
        }
      end
    end
  end

  def update
    @guild_membership = GuildMembership.find(params[:id])
    @guild = @guild_membership.guild

    @current_user_membership = @guild.membership_for(current_user)
    unless @current_user_membership.try(:royalty?)
      flash[:error] = "You don't have permission to do this action"
      redirect_to root_path
      return
    end

    message = if params["kick"]
      @guild_membership.destroy
      "Removed member from guild"
    elsif params["promote"]
      @guild_membership.update_attributes(officer: true)
      "Successfully promoted member"
    end

    respond_to do |format|
      format.html {
        flash[:success] = message
        redirect_to @guild
        return
      }
    end
  end

  def accept_invite
    @guild_membership = GuildMembership.find(params[:id])
    @guild = @guild_membership.guild

    unless @guild.membership_for(current_user).try(:royalty?)
      flash[:danger] = "You are not an admin of this guild and cannot accept users"
      redirect_to root_url
      return
    end

    @guild_membership.update_attributes(accepted: true)

    respond_to do |format|
      format.html{
        redirect_to @guild
      }
    end
  end
end
