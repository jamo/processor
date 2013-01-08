class CreateLevenshteinSimilarityForTwoSubmissions < ActiveRecord::Migration
  def up
    create_table :levenshtein_similarity_for_two_submissions do |t|
    	t.float :similarity
    	t.integer :from_submission
    	t.integer :to_submission
    	t.references :exercise
    	t.timestamps
    end
  end

  def down
  	drop_table :levenshtein_similarity_for_two_submissions
  end
end
