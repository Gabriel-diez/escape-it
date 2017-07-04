class AddNotificationIdToDevice < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :notification_id, :integer
  end
end
