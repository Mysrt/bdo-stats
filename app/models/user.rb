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
end
