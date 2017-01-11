class AddCreatedAtToMultipleTables < ActiveRecord::Migration[5.0]
  def change
    add_column :guilds, :created_at, :datetime
    add_column :guilds, :updated_at, :datetime
    add_column :guild_memberships, :created_at, :datetime
    add_column :guild_memberships, :updated_at, :datetime

    add_index :guilds, :created_at
    add_index :guilds, :updated_at
    add_index :guild_memberships, :created_at
    add_index :guild_memberships, :updated_at
  end
end
