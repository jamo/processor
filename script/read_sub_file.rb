require 'pry'
require 'fileutils'
require 'logger'

@log = Logger.new(STDOUT)

original_formatter = Logger::Formatter.new
@log.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}

file = File.read("submissions_to_users_hy.txt")
lines = file.split("\n")
lines.delete_at(1) # poistetaan otsikoiden error_explanation

keys = lines.delete_at(0) #saadaan avaimet
keys = keys.split("|")

keys = keys.map {|k| k.strip.to_sym}

all = []

lines.each do |line|
  hs = {}
  cleaned_lines = line.split("|").map {|f| f.strip}
  all << Hash[keys.zip(cleaned_lines)]
end



PATH_TO_SUBMISSIONS = "/Users/jamo/work/s2012-ohja/subs" 

all.each do |submission|
  
    @log.info("Processing submission #{submission[:submission_id]}")
    dir = "#{PATH_TO_SUBMISSIONS}/#{submission[:course_id]}/#{submission[:exercise_name]}"
    @log.info("Processing submission #{submission[:submission_id]} to #{dir}")
    FileUtils.mkpath(dir) unless File.exists?(dir)


    file_to_move = "#{PATH_TO_SUBMISSIONS}/#{submission[:submission_id]}.zip"
    destination = "#{dir}/"
    @log.debug("    Moving to dir #{dir}")
    FileUtils.mv(file_to_move, dir) if File.exists?(file_to_move)
  
  #  @log.warn("skipping #{submission[:submission_id]}")
  
end