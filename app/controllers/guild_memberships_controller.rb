class GuildMembershipsController < ApplicationController

  def create
    @guild_membership = GuildMembership.find_by_invite_hash(params.permit(:invite_hash)[:invite_hash])
    @guild = @guild_membership.guild

    respond_to do |format|
      if @guild.guild_memberships.create(user: current_user, admin: true, invitor_id: @guild_membership.user_id)
        format.html {
          flash[:success] = "Welcome to #{@guild.name}"
          redirect_to @guild
        }

      else 
        format.html {
          flash[:error] = "You cannot join this guild"
          redirect_to @guild
        }
      end
    end
  end
end
