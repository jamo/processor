class LevenshteinSimilarity < ActiveRecord::Base
  attr_accessible :similarity

  belongs_to :exercise
  belongs_to :submission
end
