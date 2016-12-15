class GuildMembership < ActiveRecord::Base

  belongs_to :user
  belongs_to :guild

  validates :user_id, uniqueness: true
end
