
require 'active_record'
#require 'standalone_migrations'
require 'yaml'
require 'logger'
#require 'activerecord_sqlite3_adapter'
require 'jdbc/sqlite3'
#StandaloneMigrations::Tasks.load_tasks
@log = Logger.new(STDOUT)

original_formatter = Logger::Formatter.new
@log.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}


dbconfig = YAML::load(File.open('db/config.yml'))


ActiveRecord::Base.establish_connection(dbconfig)
return
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))

@log.info("Database loaded")

models =  Dir.glob("../app/models/*.rb")

models.each {|model| require model}

