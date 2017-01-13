class AddHideFromMembersToGuilds < ActiveRecord::Migration[5.0]
  def change
    add_column :guilds, :hide_from_members, :boolean
  end
end
