class GuildMembershipsController < ApplicationController

  def create
    @guild_membership = GuildMembership.find_by_invite_hash(params.permit(:invite_hash)[:invite_hash])

    @guild = @guild_membership.guild
    unless @guild.membership_for(current_user)
      @new_membership = @guild.guild_memberships.create!(user: current_user, invitor_id: @guild_membership.user_id)
    end

    respond_to do |format|
      if @new_membership
        format.html {
          flash[:success] = "Welcome to #{@guild.name}"
          redirect_to @guild
        }

      else 
        format.html {
          flash[:error] = "You cannot join this guild"
          redirect_to @guild || current_user
        }
      end
    end
  end

  def accept_invite
    @guild_membership = GuildMembership.find_by_id(params[:id])
    @guild = @guild_membership.guild

    unless @guild.membership_for(current_user).try(:admin?)
      flash[:error] = "You are not an admin of this guild and cannot accept users"
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
