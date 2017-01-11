class AddAcceptedToGuildMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :guild_memberships, :accepted, :boolean, default: false
    add_index :guild_memberships, :accepted
  end
end
