class ChangeEmailColumnOnUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    remove_column :users, :email
  end
end
