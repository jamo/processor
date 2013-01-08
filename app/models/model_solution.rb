class ModelSolution < ActiveRecord::Base
  attr_accessible :filename

  belongs_to :exercise
  has_many :submission_files

end
