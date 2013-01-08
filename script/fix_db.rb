require_relative 'db'
require 'pry'



Submission.where("exercise_id IS null").each do |s|
  @log.info("processing #{s.identifier}")
  sub_file = s.submission_files.first
  sub_file_name_array = sub_file.filename.split("/")
  src_index = sub_file_name_array.index("src")
  name = sub_file_name_array[(src_index-1)]

  
  name = sub_file_name_array[(src_index-2)] if name == "result"


  e = Exercise.find_by_title(name)
  
  unless e
    submissions_index = sub_file_name_array.index("submissions")
    name = sub_file_name_array[(submissions_index+1)]
  end
  e = Exercise.find_by_title(name)
  if e
    e.submissions << s
  else 
    binding.pry
  end

end