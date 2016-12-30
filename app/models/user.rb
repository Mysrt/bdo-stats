class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true
  validates :name, uniqueness: { scope: [:family_name, :region] }
  has_many :guild_memberships
  has_many :guilds, through: :guild_memberships

  BOSS_GEAR = ["bhegs", "muskan", "giath", "tree", "zaka", "dandy", "kutum", "nouver"]

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
    self.ap >= guild.average_ap
  end

  def green_awakening_ap?
    self.awakening_ap >= guild.average_awakening_ap
  end

  def green_dp?
    self.dp >= guild.average_dp
  end

  def green_gearscore?
    self.gearscore >= guild.average_gearscore
  end
end
