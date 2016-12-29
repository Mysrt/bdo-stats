class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
end
