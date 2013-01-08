require_relative 'db'
require 'fileutils'
require 'find'
require 'pry'
require 'amatch'

include Amatch


Exercise.all.each do |exercise|
  @log.info("Processing exercise #{exercise}")
  exercise.model_solutions.each do |model_solution| #each has just one, so this will ger executed just once for each exercise
    whole_solution = ""
    model_solution.submission_files.each {|solution| whole_solution << solution.code}
    @log.info("Model solution created")
    levenshtein = Levenshtein.new(whole_solution)
    
    exercise.submissions.each do |submission|
      if submission.levenshtein_similarities == []
        @log.debug("Prosessing #{exercise} -- #{submission}")
        whole_submission = ""
      #whole_submission.clear
        submission.submission_files.each {|sub_file| whole_submission << sub_file.code}

        similarity = levenshtein.similar(whole_submission)
        @log.debug("Similarity calculated #{similarity}")
        submission.levenshtein_similarities.create(similarity: similarity)
      else
        @log.warn("skipping submission #{submission.identifier}")
      end
    end
  end
end