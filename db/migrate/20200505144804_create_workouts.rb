class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :style
      t.string :url
      t.integer :length
      t.string :intensity

      t.timestamps
    end
  end
end
