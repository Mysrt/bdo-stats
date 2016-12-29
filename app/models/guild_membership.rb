class GuildMembership < ActiveRecord::Base

  belongs_to :user
  belongs_to :guild

  validates :user_id, uniqueness: true

  validates :guild_id, presence: true
  before_create :generate_invite_hash

  def generate_invite_hash
    self.invite_hash = SecureRandom.hex(12)
  end

end
