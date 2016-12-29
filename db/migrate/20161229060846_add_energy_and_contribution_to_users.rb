class AddEnergyAndContributionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :energy, :integer
    add_column :users, :contribution, :integer
  end
end
