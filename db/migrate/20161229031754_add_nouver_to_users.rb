class AddNouverToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nouver, :boolean
  end
end
