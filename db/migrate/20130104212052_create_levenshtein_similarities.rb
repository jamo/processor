class CreateLevenshteinSimilarities < ActiveRecord::Migration
  def up
    create_table :levenshtein_similarities do |t|
    	t.float :similarity
    	t.references :exercise
    	t.references :submission
      t.timestamps
    end
  end

  def down
  	drop_table :levenshtein_similarities
  end
end
