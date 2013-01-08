class LevenshteinSimilarityController < ApplicationController

	def index
    @course = Course.find_by_id(params[:course_id])
		@exercise = @course.exercises.find_by_id(params[:exercise_id])
		@similarities = @exercise.levenshtein_similarities.scoped
    @similarities = @similarities.order('similarity DESC')
    @similarities = @similarities.where('similarity > ? ', params[:min])  if params[:min]
		
	end
end
