class LevenshteinSimilarityForTwoSubmission < ActiveRecord::Base
  attr_accessible :from_submission, :to_submission, :similarity
  belongs_to :exercise
end
