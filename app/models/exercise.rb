class Exercise < ActiveRecord::Base
  attr_accessible :title
  belongs_to :course
  has_many :submissions
  has_many :model_solutions
  #has_many :levenshtein_similarities
  has_many :submission_files, :through => :submissions
  has_many :submission_files, :through => :model_solutions
  has_many :levenshtein_similarities, :through => :submissions
  has_many :levenshtein_similarity_for_two_submissions 
end
