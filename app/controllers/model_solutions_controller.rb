class ModelSolutionsController < ApplicationController

  def index
    @exercise = Exercise.find_by_id(params[:exercise_id])
    @model_solution = @exercise.model_solutions
  end
end
