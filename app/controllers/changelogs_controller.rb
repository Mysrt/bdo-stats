class ChangelogsController < ApplicationController

  skip_before_filter :authenticate_user!
  def index
    @changelogs = Changelog.all
  end

end
