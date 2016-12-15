class GuildMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :guild_memberships do |t|
      t.integer :user_id
      t.integer :guild_id
    end

    #user can only be part of one guild
    add_index :guild_memberships, [:user_id], unique: true

    add_index :guild_memberships, [:guild_id]
    add_index :guild_memberships, [:user_id, :guild_id]
  end
end
