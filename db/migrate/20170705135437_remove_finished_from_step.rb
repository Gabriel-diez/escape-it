class RemoveFinishedFromStep < ActiveRecord::Migration[5.1]
  def change
    remove_column :steps, :finished, :boolean
  end
end
