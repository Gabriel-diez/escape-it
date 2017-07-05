class AddValueToDevice < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :value, :string
  end
end
