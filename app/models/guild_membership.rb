class GuildMembership < ActiveRecord::Base

  belongs_to :user
  belongs_to :guild
  belongs_to :invitor, class_name: "User", foreign_key: 'invitor_id'

  validates :user_id, uniqueness: true
  validates :invite_hash, uniqueness: true
  validates :guild_id, presence: true

  before_create :generate_invite_hash

  def generate_invite_hash
    self.invite_hash = SecureRandom.hex(4).upcase
  end

end
