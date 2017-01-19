class AddRedNoseToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :red_nose, :boolean
  end
end
