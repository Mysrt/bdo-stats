class AddOfficerToGuildMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :guild_memberships, :officer, :boolean
  end
end
