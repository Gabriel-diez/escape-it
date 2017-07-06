class AddDescriptionToStep < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :description, :string
  end
end
