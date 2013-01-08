class CreateExercises < ActiveRecord::Migration
  def up
    create_table :exercises do |t|
      t.string :title

      t.timestamps
    end
  end

  def down
  	drop_table :exercises
  end
end
