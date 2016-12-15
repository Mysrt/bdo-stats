class AddStatsFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ap, :integer
    add_column :users, :dp, :integer
    add_column :users, :name, :string
    add_column :users, :family_name, :string
    add_column :users, :region, :string
    add_column :users, :gear_screenshot_url, :string

    add_column :users, :bhegs, :boolean
    add_column :users, :tree, :boolean
    add_column :users, :muskan, :boolean
    add_column :users, :giath, :boolean
    add_column :users, :kutum, :boolean
    add_column :users, :zaka, :boolean
    add_column :users, :dandy, :boolean

    add_column :users, :allow_public_stat_calc, :boolean, default: true
    add_column :users, :allow_private_stat_calc, :boolean, default: true
  end
end
