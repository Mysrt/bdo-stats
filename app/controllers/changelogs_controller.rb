class ChangelogsController < ApplicationController

  skip_before_filter :authenticate_user!
  def index
    @changelogs = Changelog.all.order("created_at DESC")
  end

end
