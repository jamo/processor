class CreateSubmissions < ActiveRecord::Migration
  def up
    create_table :submissions do |t|
      t.string :identifier
      t.references :exercise

      t.timestamps
    end
  end

  def down
  	drop_table :submissions
  end
end
