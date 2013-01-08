class AddModelSolutionToExersice < ActiveRecord::Migration
def up
  	create_table :model_solutions do |t|
  		t.string :filename
  		t.references :exercise
      
      t.timestamps
  	end

  	add_column :submission_files, :exercise_id, :integer, :references => 'exercise'
    add_column :submission_files, :model_solution_id, :integer, :references => 'model_solution'

  end

  def down
  	drop_table :model_solutions
  	remove_column :submission_files, :exercise_id
    remove_column :submission_files, :model_solution_id
  	
  end
end
