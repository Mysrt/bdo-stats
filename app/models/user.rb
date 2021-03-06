class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true
  validates :name, uniqueness: { scope: [:family_name, :region] }, allow_blank: true
  has_many :guild_memberships
  has_many :guilds, through: :guild_memberships

  BOSS_GEAR = ["bhegs", "muskan", "giath", "tree", "red_nose", "zaka", "dandy", "kutum", "nouver"]

  has_attached_file :gear_screenshot, :styles => {:large => "900x900#"}
  validates_attachment :gear_screenshot, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }

  has_attached_file :avatar, :styles => {:thumb => "100x100#", :tiny => "25x25#"}
  validates_attachment :avatar, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }

  scope :accepted, -> { where(guild_memberships: {accepted: true}) }

  def self.calculate_top_awk_ap
    User.calculate_top_awakening_ap
  end

  [:ap, :awakening_ap, :dp].each do |method_name|
    define_singleton_method "calculate_top_#{method_name.to_s}" do
      sql = <<-SQL 
SELECT * FROM (
  SELECT
    users.*,
    rank() OVER(ORDER BY users.#{method_name.to_s} DESC) AS player_rank
    FROM USERS
    WHERE users.dp IS NOT NULL
    AND users.#{method_name.to_s} <= 450
    AND users.#{method_name.to_s} > 0
    AND users.verified = 't'
    AND users.private_profile = 'f'
    AND users.gear_screenshot_content_type IS NOT NULL
) AS rankings
WHERE player_rank = 1
SQL
      rank = User.find_by_sql(sql).first 
      User.find(rank["id"])
    end


    define_method "get_user_#{method_name}_ranking" do
      sql = <<-SQL 
SELECT 
  * 
FROM (
  SELECT
    users.id,
    rank() OVER(ORDER BY users.#{method_name.to_s} DESC) AS player_rank
    FROM USERS
    WHERE users.#{method_name.to_s} IS NOT NULL
    AND users.verified = 't'
    AND users.private_profile = 'f'
    AND users.gear_screenshot_content_type IS NOT NULL
  ) AS rankings
WHERE rankings.id = #{self.id}
SQL
      User.find_by_sql(sql).first.try(:player_rank)
    end

    define_method "close_#{method_name}" do
      ranking = self.send "get_user_#{method_name}_ranking".to_sym
      if ranking
        lower_bound = ranking - 5
        sql = <<-SQL 
  SELECT 
    * 
  FROM (
    SELECT
      users.*,
      rank() OVER(ORDER BY users.#{method_name.to_s} DESC) AS player_rank
      FROM USERS
      WHERE users.#{method_name.to_s} IS NOT NULL
      AND users.#{method_name.to_s} <= 450
      AND users.#{method_name.to_s} > 0
      AND users.verified = 't'
      AND users.private_profile = 'f'
      AND users.gear_screenshot_content_type IS NOT NULL
    ) AS rankings
  WHERE rankings.player_rank <= #{ranking + 5}
  AND rankings.player_rank >= #{lower_bound.negative? ? 0 : lower_bound}
  SQL

        User.find_by_sql(sql)
      else
        []
      end
    end
  end

  def guild
    @guild ||= guilds.first
  end

  def gearscore
    if ap.to_i > awakening_ap.to_i
      ap.to_i + dp.to_i
    else
      awakening_ap.to_i + dp.to_i
    end
  end

  #devise
  def email_required?
    false
  end

  def email_changed?
    false
  end

  #an item is green if it is above the guilds average
  def green_ap?
    self.ap.to_i >= guild.average_ap.to_i
  end

  def green_awakening_ap?
    self.awakening_ap.to_i >= guild.average_awakening_ap.to_i
  end

  def green_dp?
    self.dp.to_i >= guild.average_dp.to_i
  end

  def green_gearscore?
    self.gearscore.to_i >= guild.average_gearscore.to_i
  end

  def complete?
    self.name.present? && self.family_name.present? && self.ap.present? && self.awakening_ap.present?
  end
  
  def percentile_calculations
    count = User.where("users.awakening_ap IS NOT NULL AND users.ap IS NOT NULL").count
    percentile_count = (count < 100) ? count : 100
    sql = <<-SQL 
    SELECT * FROM (
SELECT
  users.id,
  ntile(#{percentile_count}) OVER(ORDER BY users.ap DESC) AS ap_percentile,
  ntile(#{percentile_count}) OVER(ORDER BY users.awakening_ap DESC) AS awakening_ap_percentile,
  rank() OVER(ORDER BY users.awakening_ap DESC) AS player_rank
  FROM USERS
  WHERE users.awakening_ap IS NOT NULL
  AND users.verified = 't'
  AND users.ap IS NOT NULL
) AS rankings
WHERE rankings.id = #{self.id}
SQL
    @percentile_calculations ||= User.find_by_sql(sql).first 
  end

end
