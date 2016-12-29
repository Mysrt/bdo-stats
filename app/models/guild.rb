class Guild < ActiveRecord::Base
  has_many :guild_memberships
  has_many :users, through: :guild_memberships

  validates :name, uniqueness: { scope: [:region] }

  def average_ap
    self.users.average("ap").to_i
  end

  def average_awakening_ap
    self.users.average("awakening_ap").to_i
  end
  
  def average_dp
    self.users.average("dp").to_i
  end

  def average_gearscore
    self.users.average("GREATEST(ap, awakening_ap) + dp").to_i
  end

  def membership_for(user)
    self.guild_memberships.where(user_id: user.id).first
  end
end
