class ChangeDeviceColumnName < ActiveRecord::Migration[5.1]
  def change
    remove_column :devices, :valid
    add_column :devices, :is_ok, :boolean, default: false
  end
end
