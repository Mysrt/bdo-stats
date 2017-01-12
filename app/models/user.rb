class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true
  validates :name, uniqueness: { scope: [:family_name, :region] }, allow_blank: true
  has_many :guild_memberships
  has_many :guilds, through: :guild_memberships

  BOSS_GEAR = ["bhegs", "muskan", "giath", "tree", "zaka", "dandy", "kutum", "nouver"]

  has_attached_file :gear_screenshot, :styles => {:large => "900x900#"}
  validates_attachment :gear_screenshot, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }

  has_attached_file :avatar, :styles => {:thumb => "100x100#", :tiny => "25x25#"}
  validates_attachment :avatar, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }

  scope :accepted, -> { where(guild_memberships: {accepted: true}) }

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
  
  def percentile_calculations
    User.where(id: self.id).select("
      users.*, 
      ntile(100) OVER(ORDER BY ap) AS ap_percentile, 
      ntile(100) OVER(ORDER BY awakening_ap) AS awakening_ap_percentile,
      rank() OVER(ORDER BY awakening_ap) AS player_rank
    ").first
  end
end
