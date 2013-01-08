#encoding: utf-8

require_relative 'db'
require 'fileutils'
require 'find'
require 'pry'
@log.warn("Aletaan lisäilemään malliratkaisuja")


def find_all_files dest_path  
  dest_path = "#{dest_path}/"
 
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

TIRA_REPO_PATH ="/Users/jamo/git/k2012-mooc"
WEEKS = Dir.glob("#{TIRA_REPO_PATH}/*")
WEEKS.delete("#{TIRA_REPO_PATH}/private")
WEEKS.delete("#{TIRA_REPO_PATH}/scripts")
WEEKS.delete("#{TIRA_REPO_PATH}/xtra")
WEEKS.delete("#{TIRA_REPO_PATH}/setti6")
WEEKS.delete("#{TIRA_REPO_PATH}/setti7")
WEEKS.delete("#{TIRA_REPO_PATH}/setti8")
WEEKS.delete("#{TIRA_REPO_PATH}/setti9")
WEEKS.delete("#{TIRA_REPO_PATH}/setti10")
WEEKS.delete("#{TIRA_REPO_PATH}/setti11")
WEEKS.delete("#{TIRA_REPO_PATH}/setti12")



EXERSICES = []
WEEKS.each {|week| EXERSICES << Dir.glob("#{week}/*")}
EXERSICES.compact!
EXERSICES.flatten!
EXERSICES.delete("#{TIRA_REPO_PATH}/private/template_project")
EXERSICES.delete("#{TIRA_REPO_PATH}/scripts/create-project")
EXERSICES.delete("#{TIRA_REPO_PATH}/scripts/upgrade-lib")
EXERSICES.delete("#{TIRA_REPO_PATH}/scripts/test-all-projects")





EXERSICES.each do |e|
	name = e.split("/")[-2..-1].join("-")
  @log.info("Processing exersice #{name}")

  if e.end_with?(".yml")
    @log.warn("Skipping #{name}")
    next
  end
	exersice = Exercise.find_or_create_by_title(name)

  files = find_all_files(e) 
  
  if  exersice.model_solutions == []
    @log.info("Adding model solution to #{name}")
    model_solution = exersice.model_solutions.create
    files.each do |file|
      sub_name  = file.split("/")
      i = sub_name.index("src")
      sub_name = sub_name[i..-1].join("/")
      #binding.pry
      model_solution.submission_files.create(filename: sub_name, code: File.read(file))
    end
  end
end

binding.pry