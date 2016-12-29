class AddLevelAndAwakeningApToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :level, :integer
    add_column :users, :awakening_ap, :integer
  end
end
