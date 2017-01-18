class AddPrivateProfileToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :private_profile, :boolean, default: false

    add_index :users, :private_profile
  end
end
