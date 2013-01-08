class LevenshteinSimilarityForTwoSubmission < ActiveRecord::Base
  attr_accessible :from_submission, :to_submission, :similarity, :exercise_id
  belongs_to :exercise
end
