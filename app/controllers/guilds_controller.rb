class GuildsController < ApplicationController

  def new
    @guild = Guild.new
  end

  def edit
    @guild = Guild.find(params[:id])
    @membership = @guild.membership_for(current_user)

    unless @membership.royalty?
      flash[:danger] = "You must be an officer of the guild to edit it"
      redirect_to root_path
      return
    end

  end

  def update
    @permitted_params = params.require(:guild).permit(:name, :hide_from_members)

    @guild = Guild.find(params[:id])
    @membership = @guild.membership_for(current_user)

    unless @membership.royalty?
      flash[:danger] = "You must be an officer of the guild to edit it"
      redirect_to root_path
      return
    end

    respond_to do |format|
      if @guild.update_attributes!(@permitted_params)
        format.html {
          flash[:success] = "Successfully updated guild"
          redirect_to @guild
          return
        }
      else
          flash[:danger] = "There was an error saving the guild, #{@guild.errors.full_messages.join(', ')}"
          redirect_to @guild
          return
      end
    end
  end

  def show
    @guild = Guild.find_by_id(params.permit(:id)[:id])
    unless @guild 
      flash[:danger] = "Guild does not exist"
      redirect_to current_user
      return
    end

    @membership = @guild.membership_for(current_user)

    unless @membership
      flash[:danger] = "You are not a member of this guild and cannot view its stats"
      redirect_to current_user || root_path
      return
    end

    @memberships = @guild.guild_memberships.where(guild_memberships: {accepted: true}).preload(:user)
    @members = @guild.users.where(guild_memberships: {accepted: true})
    @unaccepted_members = @guild.guild_memberships.where(accepted: false).order("created_at DESC")
    @invite_link = "#{request.base_url}/inv/#{@membership.invite_hash}" if @membership
  end

  def create
    if current_user.guild
      flash[:danger] = "You must leave your guild before you can make a new one"
      redirect_to current_user
      return
    end

    @guild = Guild.new(params.require(:guild).permit(:name, :hide_from_members))

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

