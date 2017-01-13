class GuildsController < ApplicationController

  def new
    @guild = Guild.new
  end

  def show
    @guild = Guild.find_by_id(params.permit(:id)[:id])
    unless @guild
      flash[:error] = "Guild does not exist"
      redirect_to current_user
      return
    end

    @memberships = @guild.guild_memberships.where(guild_memberships: {accepted: true}).preload(:user)
    @members = @guild.users.where(guild_memberships: {accepted: true})
    @unaccepted_members = @guild.guild_memberships.where(accepted: false).order("created_at DESC")
    @membership = @guild.membership_for(current_user)
    @invite_link = "#{request.base_url}/inv/#{@membership.invite_hash}" if @membership
  end

  def create
    if current_user.guild
      flash[:error] = "You must leave your guild before you can make a new one"
      redirect_to current_user
      return
    end

    @guild = Guild.new(params.require(:guild).permit(:name))

    respond_to do |format|
      if @guild.save
        @guild.guild_memberships.create!(user: current_user, admin: true, accepted: true, invitor: current_user)

        format.html {
          redirect_to @guild
          return
        }
      else
        format.html {
          flash[:error] = @guild.errors.full_messages
          render new_guild_path
        }
      end
    end
  end

end

