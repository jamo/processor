class Submission < ActiveRecord::Base
  attr_accessible :identifier
  belongs_to :exercise
  has_many :submission_files
  has_many :levenshtein_similarities
end
