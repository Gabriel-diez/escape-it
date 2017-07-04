class AddStartedFieldToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :started, :boolean, default: false
  end
end
