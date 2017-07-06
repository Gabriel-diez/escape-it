class AddSensorTypeToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :sensor_type, :string
  end
end
