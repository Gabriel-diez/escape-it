class AddStartedAtToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :started_at, :datetime
  end
end
