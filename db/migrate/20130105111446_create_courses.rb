class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :courses
    
  end
end
