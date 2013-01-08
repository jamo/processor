require_relative 'db'

def clean_line line
  return '' if line.include?"//SOLUTION"
  return '' if line.include?"// SOLUTION"
  return '' if line.include?"//BEGIN"
  return '' if line.include?"// BEGIN"
  return '' if line.include?"//END"
  return '' if line.include?"// END"
  return '' if line.include?"//STUB"
  return '' if line.include?"// STUB"
  line
end

ModelSolution.all.each do |ms|
  @log.info("Processing ModelSolution for #{ms.exercise_id}")
  ms.submission_files.each do |file|
    code = file.code
    new_code = code.split("\n").collect {|line| clean_line(line)}.join("\n")
    file.code = new_code
    file.save


  end
end