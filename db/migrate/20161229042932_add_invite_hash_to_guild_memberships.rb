class AddInviteHashToGuildMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :guild_memberships, :invite_hash, :string

    add_index :guild_memberships, :invite_hash
  end
end
