ENV['RAILS_ENV'] =  'development' #ARGV.first || ENV['RAILS_ENV'] ||nyt ku
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
#require_relative "levenstein.rb"
require 'levenshtein'

include  Levenshtein
return
require 'fileutils'
require 'find'
require 'pry'

require 'thread'

def collect_submission_text(submission)
  whole_submission = ""
  submission.submission_files.each {|sub_file| whole_submission << sub_file.code}
  whole_submission
end

queue = Queue.new
tulokset = Queue.new

producer = Thread.new do
  Exercise.scoped.order('id asc').limit(2).each do |exercise|
    @log.info("Adding exercises submissios to queue #{exercise.id}")
      exercise.submissions.each do |submission|
      exercise.submissions.where(:submission_id != submission.id).each do |other_submission|
        if LevenshteinSimilarityForTwoSubmission.where("from_submission = ? AND to_submission = ?", submission.id, other_submission.id) == []
          @log.info("    Adding submission to queue #{submission.id}  #{other_submission.id}")
          queue << [exercise,submission,other_submission]
        end
      end
    end
  end
end


def process_dif ary
  exercise = ary[0]
  submission = ary[1]
  other_submission = ary[2]
  @log.info("      Diffing submissions #{submission.id}  #{other_submission.id}")
  submission_text = collect_submission_text(submission)
  other_submission_text = collect_submission_text(other_submission)
  similarity = distancs(submission_text,other_submission_text).to_f / [submission_text.length, other_submission_text.length].max.to_f
  tulokset << LevenshteinSimilarityForTwoSubmission.new(from_submission: submission.id, to_submission: other_submission.id, similarity: similarity, exercise_id: exercise.id)
end


cons = Thread.new do 
  tulokset << process_dif(queue.pop)
end

cons2 = Thread.new do 
  tulokset << process_dif(queue.pop)
end


tallentaja = Thread.new do 
  tulokset.pop.save
  @log.info("Saved submmission difference")
end


producer.join
cons.join
cons2.join
tallentaja.join

binding.pry
