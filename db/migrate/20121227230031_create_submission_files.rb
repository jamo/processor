class CreateSubmissionFiles < ActiveRecord::Migration
  def change
    create_table :submission_files do |t|
      t.string :filename
      t.text :code
      t.references :submission

      t.timestamps
    end
  end
end
