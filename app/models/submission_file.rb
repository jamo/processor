class SubmissionFile < ActiveRecord::Base
  attr_accessible :code, :filename

  belongs_to :submission
end
