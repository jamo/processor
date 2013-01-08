ENV['RAILS_ENV'] =  'development' #ARGV.first || ENV['RAILS_ENV'] ||
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

require 'pry'

binding.pry