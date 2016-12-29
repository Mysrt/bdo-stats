class GuildsController < ApplicationController

  def new
    @guild = Guild.new
  end

  def show
    @guild = Guild.find(params.permit(:id)[:id])
    @invite_link = "#{request.base_url}/inv/#{@guild.membership_for(current_user).invite_hash}"
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
        @guild.guild_memberships.create(user: current_user)

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

