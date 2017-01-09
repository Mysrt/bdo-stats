class AddAcceptedToGuildMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :guild_memberships, :accepted, :boolean
    add_index :guild_memberships, :accepted
  end
end
