class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.integer :sensor_id
      t.boolean :valid
      t.references :step, foreign_key: true

      t.timestamps
    end
  end
end
