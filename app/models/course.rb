class Course < ActiveRecord::Base
  attr_accessible :name
  has_many :exercises
  has_many :submissions, :through => :exercises
  has_many :model_solutions, :through  => :exercises
end
