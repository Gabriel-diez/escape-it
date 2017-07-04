class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.string :name
      t.boolean :finished, default: false
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
