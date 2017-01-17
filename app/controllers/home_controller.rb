class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index

    @top_ap = User.calculate_top_ap
    @top_awk_ap = User.calculate_top_awk_ap
    @top_dp = User.calculate_top_dp
  end

end
