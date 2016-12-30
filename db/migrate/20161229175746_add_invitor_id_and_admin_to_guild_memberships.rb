class AddInvitorIdAndAdminToGuildMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :guild_memberships, :invitor_id, :integer
    add_column :guild_memberships, :admin, :boolean

    add_index :guild_memberships, :invitor_id
  end
end
