class CreateSomeDbs < ActiveRecord::Migration
  def up
    create_table :exercises do |t|
      t.string :title

      t.timestamps
    end

    create_table :submissions do |t|
      t.string :identifier
      t.references :exercise

      t.timestamps
    end

    create_table :submission_files do |t|
      t.string :filename
      t.text :code
      t.references :submission

      t.timestamps
    end

  end

  def down
  	drop_table :exercises
    drop_table :submissions
    drop_table :submission_files
  end
end
