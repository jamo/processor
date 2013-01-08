require_relative 'db'
require 'fileutils'
require 'find'
require 'pry'
@log.warn("toimii")

#Tarkasta polut!!!

def find_all_files dest_path  
  dest_path = "#{dest_path}/result/"
 
  filetype = "java"
  excludes = ["test","lib"]
  files = Array.new
  Find.find(dest_path) do |path|
    if FileTest.directory?(path)
      if excludes.include?(File.basename(path))
        Find.prune
      else
        next
      end
    else
      if path.end_with? filetype
        files << path
      end
    end
  end
  files
end


def add_files_to_db(polku)
  @log.info("Adding files from #{polku}")
  course = Course.find_or_create_by_name('s2012-ohja')
	dirs = Dir.glob("#{polku}/*.zip")
	begin
		FileUtils.mkdir("#{polku}/result")
	rescue Errno::EEXIST
		@log.warn("dir exists ")
	end

	ex_name = polku.split("/")[-1]
	e = course.exercises.find_or_create_by_title(title: ex_name)
	dirs.each do |f|
		FileUtils.rm_rf("#{polku}/result/*")

		zipput = `unzip -o #{f} -d "#{polku}/result"`
		filename = f.split("/")[-1].split(".")[0]
		unless Submission.find_by_identifier(filename)
			submission = e.submissions.create(identifier: filename)
	  	find_all_files(f.split("/")[0..-2].join("/")).each do |file|
  			submission.submission_files.create(code: File.read(file), filename: file)
  		end
  	end
	end
	FileUtils.rm_rf("#{polku}/result")
end
Dir.glob("/Users/jamo/work/s2012-ohja/submissions/*") do |dirr|
	add_files_to_db dirr
end
binding.pry

#ARGV.clear # otherwise all script parameters get passed to IRB
#IRB.start



