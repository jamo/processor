class AddReferenceFromExerciseToCourse < ActiveRecord::Migration
  def up
    add_column :exercises, :course_id, :integer, :references => 'course'
  end

  def down
    remove_column :exercises, :course_id
    
  end
end
