require_relative 'db'
require 'fileutils'
require 'find'
require 'pry'
require 'amatch'

include Amatch

def collect_submission_text(submission)
  whole_submission = ""
  submission.submission_files.each {|sub_file| whole_submission << sub_file.code}
  whole_submission
end



Exercise.all.each do |exercise|
  @log.info("Processing exercise #{exercise.title}")
  exercise.submissions.each do |submission|
    @log.info("  -- Processing submission #{submission.identifier}")
    from_text = collect_submission_text(submission)
    levenshtein = Levenshtein.new(from_text)
    exercise.submissions.where(:submission_id != submission.id).each do |other_submission|
      @log.info("      -- Processing other submission #{other_submission.identifier}")
      similarity = levenshtein.similar(collect_submission_text(other_submission))
      #binding.pry
      new_lev = LevenshteinSimilarityForTwoSubmission.create(from_submission: submission.id, to_submission: other_submission.id, similarity: similarity, exercise_id: exercise.id)
    end
  end
end