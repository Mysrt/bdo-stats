class AddAttachmentGearScreenshotToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :gear_screenshot
    end
  end

  def self.down
    remove_attachment :users, :gear_screenshot
  end
end
