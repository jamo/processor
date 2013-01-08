ENV['RAILS_ENV'] =  'development' #ARGV.first || ENV['RAILS_ENV'] ||nyt ku
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

@log = Logger.new(STDOUT)

original_formatter = Logger::Formatter.new
@log.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}

module ActiveRecord::ConnectionAdapters
  class JdbcAdapter < AbstractAdapter
    def explain(query, *binds)
      ActiveRecord::Base.connection.execute("EXPLAIN #{query}", 'EXPLAIN', binds)
    end
  end
end

require 'levenshtein'
include  Levenshtein
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
def process_dif ary
  exercise_id = ary[0]
  submission_id = ary[1]
  other_submission_id = ary[2]
  @log.info("      Diffing submissions #{submission.id}  #{other_submission.id} #{Thread.current}")
  submission_text = ary[3]
  other_submission_text = ary[4] 
  similarity = distancs(submission_text,other_submission_text).to_f / [submission_text.length, other_submission_text.length].max.to_f
  tulokset << LevenshteinSimilarityForTwoSubmission.new(from_submission: submission_id, to_submission: other_submission_id, similarity: similarity, exercise_id: exercise_id)
end


cons = Thread.new do 
  tulokset << process_dif(queue.pop)
  @log.info("popped  #{Thread.current}")
end

cons2 = Thread.new do 
  @log.info("popped  #{Thread.current}")
  tulokset << process_dif(queue.pop)
end



producer = Thread.new do
  Exercise.scoped.order('id asc').limit(2).each do |exercise|
    @log.info("Adding exercises submissios to queue #{exercise.id} #{Thread.current}")
      exercise.submissions.each do |submission|
      exercise.submissions.where(:submission_id != submission.id).each do |other_submission|
        if LevenshteinSimilarityForTwoSubmission.where("from_submission = ? AND to_submission = ?", submission.id, other_submission.id) == []
          @log.info("    Adding submission to queue #{submission.id}  #{other_submission.id} #{Thread.current}")
          queue << [exercise.id,submission.id,other_submission.id, collect_submission_text(submission), collect_submission_text(other_submission) ]
        end
      end
    end
  end

  tulokset.pop.save
  @log.info("Saved submmission difference")
end




#tallentaja = Thread.new do 
  
#end


producer.join
cons.join
cons2.join
#tallentaja.join

binding.pry
