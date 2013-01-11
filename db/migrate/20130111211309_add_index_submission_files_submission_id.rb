class AddIndexSubmissionFilesSubmissionId < ActiveRecord::Migration
  def up
    add_index :submission_files, :submission_id 
  end

  def down
    remove_index :submission_files, :submission_id 
  end
end
